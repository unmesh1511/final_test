#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/do/logger"
LOG_STS=${IOX_PATH}"/dio/do/sts"
LOG_DO_DEVICE=${IOX_PATH}"/dio/do/do_device_log"
OUT=${IOX_PATH}"/dio/do/out"

subscribe()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1" > ${OUT}
}

do_device_test1()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/do/1"
}

do_device_test2()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
	pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
	result_logs "do_device_test" ${LOG_DO_DEVICE}  ${start_time} "${pub}"
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

do_device_test1
do_device_test2

kill_process

