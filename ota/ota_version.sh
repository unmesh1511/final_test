#!/bin/bash

source env_var.sh

PASS=1234

upgrade_ver()
{
	first=${1}
	last=$(echo ${first} | awk -F "." '{print $3}' | sed 's/^0*//')
	if [[ ${2} == "up" ]];
	then 
		new=$((last+1))
	elif [[ $2 == "down" ]];
	then
		new=$((last-1))
	fi
	first=$(echo ${first} | rev)
	new=$(echo ${new} | rev)
	last=$(echo ${last} | rev)
	first=${first/${last}/${new}}
	echo $first | rev
	
}

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
	APOLLO_SL_IP=$(ifconfig sl0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
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
	IOX_INFO=$(get_iox_info)
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	info=$(get_iox_version ${IOX_IP})
	echo $info | awk '{print $16}'
}

setup()
{
	GLP_PROTO_PROC_PATH="iox/iox/glp_proto_proc.h"
	OTA_CONFIG_PATH="iox/ota_image_tool/ota_config.cfg"

#  	1. ssh to main machine
#	2. Do git pull
#	3. cd iox/iox
#	4. change GLP_PROTO_PROC_PATH
#	5. cd iox/Tizenrt/os/tools and fire ./configure.sh artik053/extra
#	6. cd ..
#	7. cp /tmp/.config .config
#	8. make
#	9. change ota config file
#	10. ./ota...
#	11. move binary file from bin/
#  	12. ssh back to apollo


	VERSION=${1}	


#	do git pull

	
	awk '/IOX_VER_STR/ {print $3}' ${GLP_PROTO_PROC_PATH} | xargs -Iregex sed -i 's/"regex"/"'${VERSION}'"/g' ${GLP_PROTO_PROC_PATH}
	awk -F "=" '/ota_image_name=/ {print $2}' ${OTA_CONFIG_PATH} | xargs -Ireg sed -i 's#reg#ota_header_v_'${VERSION}'.bin#g' ${OTA_CONFIG_PATH}
	awk -F "=" '/firmware_version=/ {print $2}' ${OTA_CONFIG_PATH} | xargs -Ireg sed -i 's/reg/'${VERSION}'/g' ${OTA_CONFIG_PATH}
	awk -F "=" '/file_name=/ {print $2}' ${OTA_CONFIG_PATH} | xargs -Ireg sed -i 's#reg#bin/ota_no_header_v_'${VERSION}'.bin#g' ${OTA_CONFIG_PATH}
 

	echo "make clean...."

    (cd "iox/TizenRT/os" && make clean)

	if [ $? -eq 1 ];
	then
		echo "make clean failed"
	fi

	(cd "iox/TizenRT/os/tools" && ./configure.sh artik053/extra)

   	cp "iox/iox/config" "iox/TizenRT/os/.config"
	
	echo "make...."

	(cd "iox/TizenRT/os" && make)
	
	if [ $? -eq 1 ];
	then
		echo "make failed"
		exit
	fi

	(cd "iox/ota_image_tool" && ./ota_builder_tool.sh)
	

}

start_svc()
{
#	allow given port on apollo
	sudo ufw allow 8080
	python -m SimpleHTTPServer 8080 &	
}

cleanup()
{
	pid=$(ps -ef | grep "python -m SimpleHTTPServer 8080" | head -n1 | awk '{print $2}')
	if [[ ! -z "${pid}" ]];
	then
		sudo kill -9 ${pid}
	fi
}


upgrade_version()
{
	curr_ver=$(get_version)
	echo "current : "${curr_ver}
	up_ver=$(upgrade_ver ${curr_ver} "up")
	echo "upgraded : "${up_ver}
	sshpass -p ${PASS} ssh unmesh@192.168.0.103 "$(typeset -f setup); setup ${up_ver}"
	sshpass -p ${PASS} scp unmesh@192.168.0.103:~/iox/ota_image_tool/bin/ota_header_v_${up_ver}.bin ota/

	IOX_INFO=$(get_iox_info)
	APOLLO_SL_IP=$(echo ${IOX_INFO} | awk '{print $1}')
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	echo "(sleep 2; echo "ota https://${APOLLO_SL_IP}:8080${IOX_PATH}/ota/ota_header_v_${up_ver}.bin /dev/mtdblock7"; sleep 600) | telnet ${IOX_IP}"
	(sleep 2; echo "ota https://${APOLLO_SL_IP}:8080${IOX_PATH}/ota/ota_header_v_${up_ver}.bin /dev/mtdblock7"; sleep 600) | telnet ${IOX_IP}
}

downgrade_version()
{
	curr_ver=$(get_version)
	echo "current : "${curr_ver}
	down_ver=$(upgrade_ver ${curr_ver} "down")
	echo "downgraded : "${down_ver}
	sshpass -p ${PASS} ssh unmesh@192.168.0.103 "$(typeset -f setup); setup ${down_ver}"
	sshpass -p ${PASS} scp unmesh@192.168.0.103:~/iox/ota_image_tool/bin/ota_header_v_${down_ver}.bin ota/

	IOX_INFO=$(get_iox_info)
	APOLLO_SL_IP=$(echo ${IOX_INFO} | awk '{print $1}')
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	echo "(sleep 2; echo "ota https://${APOLLO_SL_IP}:8080${IOX_PATH}/ota/ota_header_v_${down_ver}.bin /dev/mtdblock7"; sleep 600) | telnet ${IOX_IP}"
	(sleep 2; echo "ota https://${APOLLO_SL_IP}:8080${IOX_PATH}/ota/ota_header_v_${down_ver}.bin /dev/mtdblock7"; sleep 600) | telnet ${IOX_IP}
}

same_version()
{
	curr_ver=$(get_version)

	sshpass -p ${PASS} ssh unmesh@192.168.0.103 "$(typeset -f setup); setup ${curr_ver}"
	sshpass -p ${PASS} scp unmesh@192.168.0.103:~/iox/ota_image_tool/bin/ota_header_v_${curr_ver}.bin ota/

	IOX_INFO=$(get_iox_info)
	APOLLO_SL_IP=$(echo ${IOX_INFO} | awk '{print $1}')
	IOX_IP=$(echo ${IOX_INFO} | awk '{print $2}')
	echo "(sleep 2; echo "ota https://${APOLLO_SL_IP}:8080${IOX_PATH}/ota/ota_header_v_${curr_ver}.bin /dev/mtdblock7"; sleep 600) | telnet ${IOX_IP}"
	(sleep 2; echo "ota https://${APOLLO_SL_IP}:8080${IOX_PATH}/ota/ota_header_v_${curr_ver}.bin /dev/mtdblock7"; sleep 600) | telnet ${IOX_IP}
}

start_svc

upgrade_version

cleanup
