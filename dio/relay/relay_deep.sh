#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/relay/logger"
LOG_STS=${IOX_PATH}"/dio/relay/sts"
LOG_RELAY_DEEP=${IOX_PATH}"/dio/relay/relay_deep_log"
OUT=${IOX_PATH}"/dio/relay/out"

subscribe()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1" > ${OUT}
}

relay_deep_test1()
{
	start_time=$(date | awk '{print $4}')
	setup_time
	sleep 5
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m 'true' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1/relay-val/value/level12"
	parse_logger "No level Item present"
	result "logger"
    pub=("mosquitto_pub -m 'true' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1/relay-val/value/level12"'")
    result_logs "relay_deep_test" ${LOG_RELAY_DEEP}  ${start_time} "${pub}"
}

relay_deep_test2()
{
	start_time=$(date | awk '{print $4}')
  	subscribe &
	pids+=($!)
	mosquitto_pub -m 'true' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1/relay-val/value/level"
	parse_out
	result
    pub=("mosquitto_pub -m 'true' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1/relay-val/value/level"'
")
    result_logs "relay_deep_test" ${LOG_RELAY_DEEP}  ${start_time} "${pub}"
}

get_time()
{
    subscribe &
    pids+=($!)
    #get mru and store it in last_time 
    if [[ -s ${OUT} ]];
    then
        out_last_time=$(awk -F "," '/mru/{print $NF}' ${OUT} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
	    rm ${OUT}
    fi
}

get_time

relay_deep_test1
relay_deep_test2

sleep 10
kill_process
