#!/bin/bash

source env_var.sh
LOGGER_PATH=${IOX_PATH}"/dio/logger"
STS_PATH=${IOX_PATH}"/dio/sts"
RESULT_LOG=${IOX_PATH}"/result/result_logs"


kill_process()
{
	for pid in ${pids[@]};
	do
		echo ${pid}
		kill ${pid}
	done	
	unset pids
}

execution_time()
{
	t=$(date -d "${1}" +%s)
	t1=$(date -d "${2}" +%s)
	diff=$(expr $t1 - $t)
	echo -n " | ${diff}s" | tee -a ${RESULT_LOG}
}

result_logs()
{
	((++increment))
	test_num=${2}
	echo -n ${increment} >> ${RESULT_LOG}
	echo -n " | ${1}${test_num}" | tee -a ${RESULT_LOG} ${3}
	((test_num++)) 
	echo -n " | ${RESULT}" | tee -a ${RESULT_LOG}
	echo -n " | ${DESCRIPTION}" | tee -a ${RESULT_LOG}
	echo "" >> ${3}
	echo "START_TIME : "${4} >> ${3}
	echo ${5} >> ${DIO_CREATE_LOG} 
	if [[ ! -z ${out_sts} ]];
	then
		echo "STATUS_OUTPUT : "${out_sts} >> ${3}
		unset out_sts
	fi	
	if [[ ! -z ${out_logger} ]];
	then
		echo "LOGGER_OUTPUT : "${out_logger} >> ${3}
		unset out_logger
	fi
	end_time=$(date | awk '{print $4}')
	echo "END_TIME : "${end_time} >> ${3}
	execution_time ${4} ${end_time}
	echo "" | tee -a ${RESULT_LOG} ${3}
	echo "==============================================================================" | tee -a ${3}
}

parse_logger()
{
	sleep 5
	if [[ -s ${LOGGER_PATH} ]];
	then 
		out_logger=$(awk -F "," '/utc/{print $4}' ${LOGGER_PATH} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | xargs -Iregex grep -m1 "regex" ${LOGGER_PATH})
		logger_latest_time=$(awk -F "," '/utc/{print $4}' ${LOGGER_PATH} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		if [[ ${logger_last_time} == ${logger_latest_time} ]];
		then
			TIMESTAMP_LOGGER="FAIL"
		else
			parse=$(echo ${out_logger} | python -c 'import sys, json; print json.load(sys.stdin)["message"]')
			echo -n " | parse : "${parse}
			if [[ ${parse} == ${1} ]];
			then
				LOGGER_RESULT="PASS"
			else
				LOGGER_RESULT="FAIL"
			fi
			logger_last_time=${logger_latest_time}
		fi
	fi
	rm ${LOGGER_PATH}
}

parse_sts()
{
	sleep 5
	if [[ -s ${STS_PATH} ]];
	then 
		out_sts=$(awk -F "," '/mru/{print $NF}' ${STS_PATH} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | xargs -Iregex grep -m1 "regex" ${STS_PATH})
		sts_latest_time=$(awk -F "," '/mru/{print $NF}' ${STS_PATH} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		sleep 2
		if [[ ${sts_last_time} == ${sts_latest_time} ]];
		then
			TIMESTAMP_STS="FAIL"
		else
			state=$(echo ${out_sts} | python -c 'import sys, json; print json.load(sys.stdin)["state"]')
			echo -n " | state : "${state}
			if [[ ${state} == ${1} ]];
			then
				STS_RESULT="PASS"
			else
				STS_RESULT="FAIL"
			fi
			sts_last_time=${sts_latest_time}
		fi
	fi
	rm ${STS_PATH}
}

result()
{
	if [[ ${1} == "logger" ]];
	then
		if [[ ${TIMESTAMP_LOGGER} == "FAIL" ]];
		then
			RESULT="FAIL"
			DESCRIPTION="LOGGER [ TIMESTAMP ]"
		else
			if [[ ${LOGGER_RESULT} == "PASS" ]];
			then
				RESULT="PASS"
				DESCRIPTION="-"
			elif [[ ${LOGGER_RESULT} == "FAIL" ]];
			then
				RESULT="FAIL"
				DESCRIPTION="LOGGER [ ${parse} ]"
			fi
		fi
	elif [[ ${1} == "sts" ]];
	then
		if [[ ${TIMESTAMP_STS} == "FAIL" ]];
		then
			RESULT="FAIL"
			DESCRIPTION="LOGGER [ TIMESTAMP ]"
		else
			if [[ ${STS_RESULT} == "PASS" ]];
			then
				RESULT="PASS"
				DESCRIPTION="-"
			elif [[ ${STS_RESULT} == "FAIL" ]];
			then
				RESULT="FAIL"
				DESCRIPTION="LOGGER [ ${parse} ]"
			fi
		fi
	fi
	unset_var
}

unset_var()
{
	unset TIMESTAMP_LOGGER
	unset TIMESTAMP_STS
	unset LOGGER_RESULT
	unset STS_RESULT
}

subscribe_logger_event()
{
	mosquitto_sub -t "glp/0/./=logger/event" > ${LOGGER_PATH}
	pids+=($!)
}

setup_time()
{
	subscribe_logger_event &
	subscribe_sts_event &

	sleep 5

	if [[ -s ${LOGGER_PATH} ]];
	then
		logger_last_time=$(awk -F "," '/utc/{print $4}' ${LOGGER_PATH} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
	fi

	if [[ -s ${STS_PATH} ]];
	then
		sts_last_time=$(awk -F "," '/mru/{print $NF}' ${STS_PATH} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
	fi

}
