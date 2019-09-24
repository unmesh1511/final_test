#!/bin/bash

source env_var.sh
source iox.config
source iox_info.sh

#cat /dev/ttyUSB${IOX_LOG_PORT} > ${MINICOM_LOGS} &
#mini_id=$!

IOX_VERSION=$(get_version)

get_info()
{
	SID=$(mosquitto_sub -C 1 -t glp/0/././sid)
#	info_msg=$(mosquitto_sub -C 1 -t iox/info)
#	IOX_IP=$(echo ${info_msg} | python -c 'import sys, json; print json.load(sys.stdin)["iox_ip"]')
#	LOGICAL_ID=$(echo ${info_msg} | python -c 'import sys, json; print json.load(sys.stdin)["logical_id"]')
#	INSTALL_ID=$(echo ${info_msg} | python -c 'import sys, json; print json.load(sys.stdin)["install_id"]')
	info=$(get_iox_mac ${IOX_IP}) 
	INSTALL_ID=$(echo ${info} | awk '{print $19}')
	LOGICAL_ID=$(echo ${info} | awk '{print $24}')
	echo "IOX_INSTALL_ID="${INSTALL_ID} >> ${IOX_CONFIG_PATH}
	echo "IOX_LOGICAL_ID="${LOGICAL_ID} >> ${IOX_CONFIG_PATH}	
	echo "SID="${SID} >> ${IOX_CONFIG_PATH}
	if [[ ! -z ${LOGICAL_ID} ]];
	then
		echo "DIO_DEV_NAME="${LOGICAL_ID}.dio >> ${IOX_CONFIG_PATH}
		echo "SYS_DEV_NAME="${LOGICAL_ID}.sys >> ${IOX_CONFIG_PATH}
		echo "METER_DEV_NAME="${LOGICAL_ID}.meter >> ${IOX_CONFIG_PATH}
	else
		echo "DIO_DEV_NAME=dio" >> ${IOX_CONFIG_PATH}
		echo "SYS_DEV_NAME=sys" >> ${IOX_CONFIG_PATH}
		echo "METER_DEV_NAME=meter" >> ${IOX_CONFIG_PATH}
	fi
		
}


# DESCRIPTION : read from files.list of each device and add it with it's pull path to run_list

read_from_files_list()
{
	wdir=$(pwd)
	while read line;
	do
		echo ${wdir}"/"${line} >> ${RUN_LIST_PATH}
	done < "files.list"
}

# DESCRIPTION : add all files.list to run_list

add_all()
{
	echo "iox : "${IOX_PATH}
	cd ${IOX_PATH}"/dio"
	read_from_files_list 
	cd ${IOX_PATH}"/dio/do"
	read_from_files_list
	cd ${IOX_PATH}"/dio/din"
	read_from_files_list
	cd ${IOX_PATH}"/dio/relay"
	read_from_files_list
	cd ${IOX_PATH}"/meter/3phase"
	read_from_files_list
	cd ${IOX_PATH}"/modbus"
	read_from_files_list
	cd ${IOX_PATH}"/dcm"
	read_from_files_list
	cd ${IOX_PATH}"/sys"
	read_from_files_list
}

# DESCRIPTION : execute the run_list file

exec_RUN_LIST_PATH()
{
	echo -e "\n\n"
	echo -e "\t\t\t\t\t\tTestsuite Version : 1.0.0\n\t\t\t\t\t\tIOX Version : ${IOX_VERSION}\n\t\t\t\t\t\tApollo Version : v1\n\t\t\t\t\t\tApollo Config :" | boxes
	echo -e "\n\n"
	#remove duplicates first
	sort -u ${RUN_LIST_PATH} -o ${RUN_LIST_PATH}
	chmod +x ${RUN_LIST_PATH}
	cd ${IOX_PATH}
	./run_list 2> /dev/null
	awk '{print  NR," | ", $0}' ${RESULT_PATH} > temp
	mv temp ${RESULT_PATH}
	echo "" >> ${RESULT_PATH}

	echo -n "Sr.No" >> ${RESULT_PATH}
	echo -n " |  TEST_NAME" >> ${RESULT_PATH}
#	echo -n " | ACTION_RESULT" >> ${RESULT_PATH}
	echo -n " | TEST_RESULT" >> ${RESULT_PATH}
	echo -n " | DESCRIPTION" >> ${RESULT_PATH}
	echo -n " | EXECUTION_TIME" >> ${RESULT_PATH}
	tac ${RESULT_PATH} | awk 'NR==1 {line =$0; next} 1; END{print line}' | tac > temp | mv temp ${RESULT_PATH}
	column ${RESULT_PATH} -t -s '|' > temp
	mv temp ${RESULT_PATH}
	sed -i '1i\\' ${RESULT_PATH}
	sleep 1
	sed -i '3i\\' ${RESULT_PATH}
	sed -i '6,$d' ${IOX_CONFIG_PATH}
	
	sudo kill -9 ${mini_id}
}


run_test()
{
	touch ${RUN_LIST_PATH}
	case $1 in 
		'g')
			for directory in ${G_OPTIONS[@]};
			do
				cd ${directory}
				read_from_files_list
			done	
			;;
		'i')
			if [[ -f "${IOX_PATH}/${2}" ]];
			then
				individual_test_case=${IOX_PATH}/${2}
				echo ${individual_test_case} >> ${RUN_LIST_PATH}
			else
				echo "Invalid Test"
				exit 0
			fi
			;;
		'l')
			cd ${IOX_PATH}
			while read line;
			do
				if [[ -f "${IOX_PATH}/${line}" ]];
				then
					echo ${IOX_PATH}/${line} >> ${RUN_LIST_PATH}
				else
					echo "Invalid Test : "${line}
				fi
			done < ${2}
			;;
		'x')                         
			if [[ ${3} -eq 1 ]];
			then
				add_all
			fi  
			EXCLUDE_FILE_PATH=${IOX_PATH}"/exclude_testcases.list" 
			echo ${2} >> ${EXCLUDE_FILE_PATH}
			while read line;
			do
				base_name=$(basename ${line})
				sed -i "/${base_name}/d" ${RUN_LIST_PATH} 
			done < ${EXCLUDE_FILE_PATH}										
			#execute run_list file
			;;
		'X')
			if [[ ${3} -eq 1 ]];
			then
				add_all
			fi  
			EXCLUDE_FILE_PATH=${IOX_PATH}/${2}
			while read line;
			do 
				if [[ -f "${IOX_PATH}/${line}" ]];
				then
					base_name=$(basename ${line})
					sed -i "/${base_name}/d" ${RUN_LIST_PATH}
				else
					echo "Invalid Line : "${line}
				fi
			done < ${EXCLUDE_FILE_PATH}				
			;;
	
	esac
}


get_info

command_line_option=0
x_EXCLUDE_FLAG=0
X_EXCLUDE_FLAG=0

while getopts "g:i:x:X:hl:" opt;
	do
		((command_line_option++))
		case ${opt} in 
			'g')
				IFS="," 	
				read -ra temp <<< "${OPTARG}"   # g_options is an array of -g option values
				for option in ${temp[@]};
				do
					if [ -d "${IOX_PATH}/${option}" ]
					then
						G_OPTIONS+=("${IOX_PATH}/${option}")
					else
						echo "Incorrect Option : "${option}
						exit 0
					fi
				done
				#...................
				run_test 'g'
				;;
			'i')
				if [[ ${OPTARG} == "ota" ]];
				then
					${IOX_PATH}"/ota/ota_version.sh"
					exit	
				elif [[ ${OPTARG} == "long_run" ]];
				then
					${IOX_PATH}"/long_run/iox_test_dio_meter.sh"
					exit	
				fi
				run_test 'i' ${OPTARG}
				;;
			'l') 																					#you need to specify either full path or path relative to iox_test directory
				run_test 'l' ${OPTARG}
				;;
			'x')
				if [[ -f "${IOX_PATH}/${OPTARG}" ]];
				then
					x_EXCLUDE_FLAG=1
					x_ARGUMENTS=${OPTARG}
				else
					echo "Invalid Test"
					exit 0
				fi
				;;
			'X')
				X_EXCLUDE_FLAG=1
				X_ARGUMENTS=${OPTARG}
				;;
			'h')
				echo "option was h" 
				;;
		esac
	done

if [[ ${command_line_option} -eq 0 ]];
then
	add_all
fi

if [[ ${x_EXCLUDE_FLAG} -eq 1 ]];
then
	if [[ ${command_line_option} -gt 1 ]];
	then
		run_test 'x' ${x_ARGUMENTS} 0
	elif [[ ${command_line_option} -eq 1 ]];
	then
		run_test 'x' ${x_ARGUMENTS} 1
	fi
fi

if [[ ${X_EXCLUDE_FLAG} -eq 1 ]];
then
	if [[ ${command_line_option} -gt 1 ]];
	then
		run_test 'X' ${X_ARGUMENTS} 0
	elif [[ ${command_line_option} -eq 1 ]];
	then
		run_test 'X' ${X_ARGUMENTS} 1
	fi
fi

exec_RUN_LIST_PATH

if [[ -f "${RUN_LIST_PATH}" ]];
then 
	rm ${RUN_LIST_PATH}
fi
