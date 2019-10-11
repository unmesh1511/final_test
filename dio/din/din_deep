#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/din/logger"
LOG_STS=${IOX_PATH}"/dio/din/sts"
LOG_DIN_DEEP=${IOX_PATH}"/dio/din/din_deep_log"
OUT=${IOX_PATH}"/dio/din/out"

subscribe()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1" > ${OUT}
}

din_deep_test1()
{
	start_time=$(date | awk '{print $4}')
	setup_time
	sleep 5
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '30' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/dia/1/input/monitor/rate" 
	parse_logger "Error in parsing json object"
	result "logger"
    pub=("mosquitto_pub -m '30' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/dia/1/input/monitor/rate"'")
    result_logs "din_deep_test" ${LOG_DIN_DEEP}  ${start_time} "${pub}"
}

din_deep_test2()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_pub -m '30' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/di-vala/monitor/rate" 
}

din_deep_test3()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"
	sleep 5
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"'")
    result_logs "din_deep_test" ${LOG_DIN_DEEP}  ${start_time} "${pub}"
}

din_deep_test4()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"monitor":{"rate":40,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input"
	sleep 5
	parse_out
	result
    pub=("mosquitto_pub -m '{"monitor":{"rate":40,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input"
'")
    result_logs "din_deep_test" ${LOG_DIN_DEEP}  ${start_time} "${pub}"
}

din_deep_test5()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"rate":50}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input/monitor"
	sleep 5
	parse_out
	result
    pub=("mosquitto_pub -m '{"rate":50}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input/monitor"'")
    result_logs "din_deep_test" ${LOG_DIN_DEEP}  ${start_time} "${pub}"
}

din_deep_test6()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '40' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input/monitor/rate"
	sleep 5
	parse_out
	result
    pub=("mosquitto_pub -m '40' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input/monitor/rate"'")
    result_logs "din_deep_test" ${LOG_DIN_DEEP}  ${start_time} "${pub}"
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

din_deep_test1
#din_deep_test2
din_deep_test3
din_deep_test4
din_deep_test5
din_deep_test6

kill_process

