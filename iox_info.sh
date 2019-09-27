#!/bin/bash

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
	sl=${1}
	APOLLO_SL_IP=$(ifconfig ${sl} | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
	echo ${APOLLO_SL_IP}
	IOX_IP=$(upgrade_ip ${APOLLO_SL_IP})
	echo ${IOX_IP}
	
}

get_iox_version()
{
	(sleep 1; echo "iox_version"; sleep 1;  echo "exit") | telnet ${1} 2>/dev/null
}

get_version()
{
	IOX_INFO=$(get_iox_info ${SL_INTERFACE})
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	info=$(get_iox_version ${IOX_IP})
	echo $info | awk '{print $16}'
}

get_iox_mac()
{
	(sleep 2; echo "iox_mac | head -n2"; sleep 5; echo "exit") | telnet ${1} 2>/dev/null
}

get_details()
{
	IOX_SL_INTERFACE=${1}
	IOX_INFO=$(get_iox_info ${IOX_SL_INTERFACE})
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	info=$(get_iox_mac ${IOX_IP})
	echo ${info}
}
