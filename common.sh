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
#	echo -n " | ${ACTION_RESULT}" | tee -a ${RESULT_PATH}
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
	if [[ ! -z ${out_msg} ]];
	then
		echo "OUTPUT : "${out_msg} >> ${2}
		unset out_msg
	fi	
	if [[ ! -z ${get_msg} ]];
	then
		echo "OUTPUT : "${get_msg} >> ${2}
		unset get_msg
	fi	
	end_time=$(date | awk '{print $4}')
	echo "END_TIME : "${end_time} >> ${2}
	execution_time ${3} ${end_time}
	echo "" | tee -a ${RESULT_PATH} ${2}
	echo "==========================================================================================" | tee -a ${2}
}

parse_logger()
{
	if [[ $# -eq 0 ]];
	then
		LOGGER_RESULT="PASS"		
	else	
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
	fi
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
			if [[ ${state} == ${1} ]];
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

parse_out()
{
    sleep 5
    if [[ -s ${OUT} ]];
    then
		out_msg=$(awk -F "," '/mru/{print $NF}' ${OUT} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | xargs -Iregex grep -m1 "regex" ${OUT})
	    out_latest_time=$(awk -F "," '/mru/{print $NF}' ${OUT} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
        if [[ ${out_last_time} == ${out_latest_time} ]];
        then
            TIMESTAMP_OUT="FAIL"
        else
            OUT_RESULT="PASS"
            out_last_time=${out_latest_time}
        fi
        rm ${OUT}
    else
        OUT_EMPTY="TRUE"
    fi
}

parse_get()
{
    sleep 5
    if [[ -s ${OUT} ]];
    then
		get_msg=$(tail -1 ${OUT})
        if [[ ${1} != "corr" ]];
        then
            get_parse=$(cat ${OUT} | python -c 'import sys, json; a=json.load(sys.stdin)["result"];print a[0]["error"]')
            if [[ ${get_parse} == ${1} ]];
            then
                GET_RESULT="PASS"
            else
                GET_RESULT="FAIL"
            fi
        else
		    get_parse=$(cat ${OUT} | python -c 'import sys, json; print json.load(sys.stdin)["corr"]')
            if [[ ${get_parse} == "abcd" ]];
            then
                GET_RESULT="PASS"
            else
                GET_RESULT="FAIL"
            fi
        fi
        rm ${OUT}
    else
        GET_EMPTY="TRUE"
    fi
}


result()
{
	if [[ ${1} == "logger" ]];
	then
		if [[ ${LOGGER_EMPTY} == "TRUE" ]];
		then
			RESULT="RESULT : FAIL"
			DESCRIPTION="LOGGER [ EMPTY ]"
		elif [[ ${TIMESTAMP_LOGGER} == "FAIL" ]];
		then
			RESULT="RESULT : FAIL"
			DESCRIPTION="LOGGER [ TIMESTAMP ]"
		else
			if [[ ${LOGGER_RESULT} == "PASS" ]];
			then
				RESULT="RESULT : PASS"
				DESCRIPTION="-"
			elif [[ ${LOGGER_RESULT} == "FAIL" ]];
			then
				RESULT="RESULT : FAIL"
				DESCRIPTION="LOGGER [ ${parse} ]"
			fi
		fi
	elif [[ ${1} == "sts" ]];
	then
		if [[ ${STS_EMPTY} == "TRUE" ]];
		then
			RESULT="RESULT : FAIL"
			DESCRIPTION="STS [ EMPTY ]"
		elif [[ ${TIMESTAMP_STS} == "FAIL" ]];
		then
			RESULT="RESULT : FAIL"
			DESCRIPTION="STS [ TIMESTAMP ]"
		else
			if [[ ${STS_RESULT} == "PASS" ]];
			then
				RESULT="RESULT : PASS"
				DESCRIPTION="-"
			elif [[ ${STS_RESULT} == "FAIL" ]];
			then
				RESULT="RESULT : FAIL"
				DESCRIPTION="STS [ ${state} ]"
			fi
		fi
	elif [[ ${1} == "get" ]];
	then
		if [[ ${GET_EMPTY} == "TRUE" ]];
		then
			RESULT="RESULT : FAIL"
			DESCRIPTION="GET [ EMPTY ]"
		else
			if [[ ${GET_RESULT} == "PASS" ]];
			then
				RESULT="RESULT : PASS"
				DESCRIPTION="-"
			elif [[ ${GET_RESULT} == "FAIL" ]];
			then
				RESULT="RESULT : FAIL"
				DESCRIPTION="GET [ - ]"
			fi
		fi
	else
		if [[ ${OUT_EMPTY} == "TRUE" ]];
		then
			RESULT="RESULT : FAIL"
			DESCRIPTION="OUT [ EMPTY ]"
		elif [[ ${TIMESTAMP_OUT} == "FAIL" ]];
		then
			RESULT="RESULT : FAIL"
			DESCRIPTION="OUT [ TIMESTAMP ]"
		else
			if [[ ${OUT_RESULT} == "PASS" ]];
			then
				RESULT="RESULT : PASS"
				DESCRIPTION="-"
			elif [[ ${OUT_RESULT} == "FAIL" ]];
			then
				RESULT="RESULT : FAIL"
				DESCRIPTION="OUT [ - ]"
			fi
		fi

	fi
	unset_var
}

unset_var()
{
	unset TIMESTAMP_LOGGER
	unset TIMESTAMP_STS
	unset TIMESTAMP_OUT
	unset LOGGER_RESULT
	unset LOGGER_EMPTY
	unset STS_RESULT
	unset STS_EMPTY
	unset OUT_RESULT
	unset OUT_EMPTY
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

dev_provision()
{
	mosquitto_pub -m '{"action":"provision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${1}/do"
}

dev_deprovision()
{
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${1}/do"
}

dev_delete()
{
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${1}/do"
}
