#!/bin/bash

source env_var.sh


kill_process()
{
	for pid in ${pids[@]};
	do
		pkill -9 -P ${pid}
	done	
	unset pids
}

execution_time()
{
	t=$(date -d "${1}" +%s)
	t1=$(date -d "${2}" +%s)
	diff=$(expr $t1 - $t)
	echo -n " | ${diff}s" | tee -a ${RESULT_PATH}
}

result_logs()
{
	((++test_num)) 
	echo -n "${1}${test_num}" | tee -a ${RESULT_PATH} ${2}
	echo -n " | ${ACTION_RESULT}" | tee -a ${RESULT_PATH}
	echo -n " | ${RESULT}" | tee -a ${RESULT_PATH}
	echo -n " | ${DESCRIPTION}" | tee -a ${RESULT_PATH}
	echo "" >> ${2}
	echo "START_TIME : "${3} >> ${2}
	echo ${4} >> ${2} 
	if [[ ! -z ${out_sts} ]];
	then
		echo "STATUS_OUTPUT : "${out_sts} >> ${2}
		unset out_sts
	fi	
	if [[ ! -z ${out_logger} ]];
	then
		echo "LOGGER_OUTPUT : "${out_logger} >> ${2}
		unset out_logger
	fi
	end_time=$(date | awk '{print $4}')
	echo "END_TIME : "${end_time} >> ${2}
	execution_time ${3} ${end_time}
	echo "" | tee -a ${RESULT_PATH} ${2}
	echo "==============================================================================" | tee -a ${2}
}

parse_logger()
{
	sleep 5
	if [[ -s ${LOG_EVENT_LOGGER} ]];
	then 
		LOGGER_EMPTY="FALSE"
		out_logger=$(awk -F "," '/utc/{print $4}' ${LOG_EVENT_LOGGER} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | xargs -Iregex grep -m1 "regex" ${LOG_EVENT_LOGGER})
		logger_latest_time=$(awk -F "," '/utc/{print $4}' ${LOG_EVENT_LOGGER} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		if [[ ${logger_last_time} == ${logger_latest_time} ]];
		then
			TIMESTAMP_LOGGER="FAIL"
		else
			parse=$(echo ${out_logger} | python -c 'import sys, json; print json.load(sys.stdin)["message"]')
			if [[ ${parse} == *"${1}"* ]];
			then
				LOGGER_RESULT="PASS"
			else
				LOGGER_RESULT="FAIL"
			fi
			logger_last_time=${logger_latest_time}
		fi
	else
		LOGGER_EMPTY="TRUE"
	fi
	rm ${LOG_EVENT_LOGGER}
}

parse_sts()
{
	sleep 5
	if [[ -s ${LOG_STS} ]];
	then 
		STS_EMPTY="FALSE"
		out_sts=$(awk -F "," '/mru/{print $NF}' ${LOG_STS} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | xargs -Iregex grep -m1 "regex" ${LOG_STS})
		sts_latest_time=$(awk -F "," '/mru/{print $NF}' ${LOG_STS} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		sleep 2
		if [[ ${sts_last_time} == ${sts_latest_time} ]];
		then
			TIMESTAMP_STS="FAIL"
		else
			state=$(echo ${out_sts} | python -c 'import sys, json; print json.load(sys.stdin)["state"]')
			if [[ ${state} == *"${1}"* ]];
			then
				STS_RESULT="PASS"
			else
				STS_RESULT="FAIL"
			fi
			sts_last_time=${sts_latest_time}
		fi
	else
		STS_EMPTY="TRUE"
	fi
	rm ${LOG_STS}
}

result()
{
	if [[ ${1} == "logger" ]];
	then
		if [[ ${LOGGER_EMPTY} == "TRUE" ]];
		then
			RESULT="FAIL"
			DESCRIPTION="LOGGER [ EMPTY ]"
		elif [[ ${TIMESTAMP_LOGGER} == "FAIL" ]];
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
		if [[ ${STS_EMPTY} == "TRUE" ]];
		then
			RESULT="FAIL"
			DESCRIPTION="STS [ EMPTY ]"
		elif [[ ${TIMESTAMP_STS} == "FAIL" ]];
		then
			RESULT="FAIL"
			DESCRIPTION="STS [ TIMESTAMP ]"
		else
			if [[ ${STS_RESULT} == "PASS" ]];
			then
				ACTION_RESULT="ACTION : PASS"
				RESULT="RESULT : PASS"
				DESCRIPTION="-"
			elif [[ ${STS_RESULT} == "FAIL" ]];
			then
				ACTION_RESULT="FAIL"
				RESULT="RESULT : PASS"
				DESCRIPTION="STS [ ${parse} ]"
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
	unset LOGGER_EMPTY
	unset STS_RESULT
	unset STS_EMPTY
}

subscribe_logger_event()
{
	mosquitto_sub -t "glp/0/./=logger/event" > ${LOG_EVENT_LOGGER}
}

setup_time()
{
	subscribe_logger_event &
	pids+=($!)
	subscribe_sts_event &
	pids+=($!)
	
	sleep 5

	if [[ -s ${LOG_EVENT_LOGGER} ]];
	then
		logger_last_time=$(awk -F "," '/utc/{print $4}' ${LOG_EVENT_LOGGER} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		rm ${LOG_EVENT_LOGGER}
	fi

	if [[ -s ${LOG_STS} ]];
	then
		sts_last_time=$(awk -F "," '/mru/{print $NF}' ${LOG_STS} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		rm ${LOG_STS}
	fi

}
