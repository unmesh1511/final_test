#!/bin/bash

if [[ "$#" -ne 2 ]];
then
	echo "usage   : ${0} <ota_filename> <iox_sl_interface>"
	echo "example : ${0} ota_header_v_2_00_001.bin sl0"
	exit
fi

BINARY=${1}

SL_INTERFACE=${2}

trap cleanup SIGINT;

upgrade_ip()
{
    IP=$1
    IP_HEX=$(printf '%.2X%.2X%.2X%.2X\n' `echo $IP | sed -e 's/\./ /g'`)
	NEXT_IP_HEX=$(printf %.8X `echo $(( 0x$IP_HEX + 1 ))`)
    NEXT_IP=$(printf '%d.%d.%d.%d\n' `echo $NEXT_IP_HEX | sed -r 's/(..)/0x\1 /g'`)
    echo "$NEXT_IP"
}

get_iox_info()
{
	APOLLO_SL_IP=$(ifconfig ${SL_INTERFACE} | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
	echo ${APOLLO_SL_IP}
	IOX_IP=$(upgrade_ip ${APOLLO_SL_IP})
	echo ${IOX_IP}
}

start_svc()
{
#	allow given port on apollo
	sudo ufw allow 8080
	python -m SimpleHTTPServer 8080 &	
}

cleanup()
{
	sudo ufw delete allow 8080

	pid=$(ps -ef | grep "python -m SimpleHTTPServer 8080" | head -n1 | awk '{print $2}')
	if [[ ! -z "${pid}" ]];
	then
		sudo kill -9 ${pid}
	fi
}

ota()
{

	IOX_INFO=$(get_iox_info)
	APOLLO_SL_IP=$(echo ${IOX_INFO} | awk '{print $1}')
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	
	echo "(sleep 2; echo "ota https://${APOLLO_SL_IP}:8080/${BINARY} /dev/mtdblock7"; sleep 600) | telnet ${IOX_IP}"
	(sleep 2; echo "ota https://${APOLLO_SL_IP}:8080/${BINARY} /dev/mtdblock7"; sleep 600) | telnet ${IOX_IP}
}

start_svc

ota

cleanup
