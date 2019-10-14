#!/bin/bash -x

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/din/logger"
LOG_DIN_DEVICE=${IOX_PATH}"/dio/din/din_device_log"
OUT=${IOX_PATH}"/dio/din/out"

subscribe()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1" > ${OUT}
}

din_device_test1()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"frequency","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/di/1"
}

din_device_test2()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"frequency","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"	
	parse_out
	result
	pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"frequency","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"'")
	result_logs "din_device_test" ${LOG_DIN_DEVICE}  ${start_time} "${pub}"
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

#din_device_test1
din_device_test2

kill_process

