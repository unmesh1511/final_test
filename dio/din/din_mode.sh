#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_DIN_MODE=${IOX_PATH}"/dio/din/din_mode_log"
OUT=${IOX_PATH}"/dio/din/out"

subscribe()
{
    mosquitto_sub -t glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1 > ${OUT}
}

din_mode_test1()
{  
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"'")
    result_logs "din_mode_test" ${LOG_DIN_MODE}  ${start_time} "${pub}"
}

din_mode_test2()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"counter","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"counter","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"'
")
    result_logs "din_mode_test" ${LOG_DIN_MODE}  ${start_time} "${pub}"
}

din_mode_test3()
{

	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"frequency","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"frequency","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"'
")
    result_logs "din_mode_test" ${LOG_DIN_MODE}  ${start_time} "${pub}"
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

din_mode_test1
din_mode_test2
din_mode_test3

kill_process

