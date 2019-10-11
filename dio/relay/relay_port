#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/relay/logger"
LOG_STS=${IOX_PATH}"/dio/relay/sts"
LOG_RELAY_PORT=${IOX_PATH}"/dio/relay/relay_port_log"
OUT=${IOX_PATH}"/dio/relay/out"

subscribe()
{
	mosquitto_sub -t glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/${1} > ${OUT}
}

relay_port_test1()
{
	start_time=$(date | awk '{print $4}')
	get_time 1
	sleep 5
	subscribe 1 &
	pids+=($!)
	mosquitto_pub -m '{"relay-val":{"value":{"level":true}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"relay-val":{"value":{"level":true}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1"'")
    result_logs "relay_port_test" ${LOG_RELAY_PORT}  ${start_time} "${pub}"
}

relay_port_test2()
{
	start_time=$(date | awk '{print $4}')
	get_time 2
	sleep 5
	subscribe 2 &
	pids+=($!)
	mosquitto_pub -m '{"relay-val":{"value":{"level":true}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/2" 
	parse_out
	result
    pub=("mosquitto_pub -m '{"relay-val":{"value":{"level":true}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/2"'")
    result_logs "relay_port_test" ${LOG_RELAY_PORT}  ${start_time} "${pub}"
}

relay_port_test3()
{
	start_time=$(date | awk '{print $4}')
	setup_time
	sleep 5
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"relay-val":{"value":{"level":true}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/3"
	parse_logger "port asked for is not valid"
	result "logger"
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1"'
")
    result_logs "relay_port_test" ${LOG_RELAY_PORT}  ${start_time} "${pub}"
}

get_time()
{
	subscribe ${1} &
	pids+=($!)
	#get mru and store it in last_time 
	if [[ -s ${OUT} ]];
	then
		out_last_time=$(awk -F "," '/mru/{print $NF}' ${OUT} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		rm ${OUT}
	fi
}

relay_port_test1
relay_port_test2
relay_port_test3

kill_process

