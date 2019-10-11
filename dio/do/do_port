#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/do/logger"
LOG_STS=${IOX_PATH}"/dio/do/sts"
LOG_DO_PORT=${IOX_PATH}"/dio/do/do_port_log"
OUT=${IOX_PATH}"/dio/do/out"

subscribe()
{
	mosquitto_sub -t glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/${1} > ${OUT}
}

do_port_test1()
{
	start_time=$(date | awk '{print $4}')
	get_time 1
	sleep 5
	subscribe 1 &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_port_test" ${LOG_DO_PORT}  ${start_time} "${pub}"
}

do_port_test2()
{
	start_time=$(date | awk '{print $4}')
	get_time 2
	sleep 5
	subscribe 2 &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/2"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/2"'
")
    result_logs "do_port_test" ${LOG_DO_PORT}  ${start_time} "${pub}"
}

do_port_test3()
{
	start_time=$(date | awk '{print $4}')
	get_time 3
	sleep 5
	subscribe 3 &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/3"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/3"'
")
    result_logs "do_port_test" ${LOG_DO_PORT}  ${start_time} "${pub}"
}

do_port_test4()
{
	start_time=$(date | awk '{print $4}')
	get_time 4
	sleep 5
	subscribe 4 &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/4"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/4"'
")
    result_logs "do_port_test" ${LOG_DO_PORT}  ${start_time} "${pub}"
}

do_port_test5()
{
	start_time=$(date | awk '{print $4}')
	get_time 5
	sleep 5
	subscribe 5 &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/5"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/5"'
")
    result_logs "do_port_test" ${LOG_DO_PORT}  ${start_time} "${pub}"
}

do_port_test6()
{
	start_time=$(date | awk '{print $4}')
	get_time 6
	sleep 5
	subscribe 6 &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/6"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/6"'
")
    result_logs "do_port_test" ${LOG_DO_PORT}  ${start_time} "${pub}"
}

do_port_test7()
{
	start_time=$(date | awk '{print $4}')
	setup_time
	sleep 5
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/8"
	parse_logger "The port asked for is not valid"
	result "logger"
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/8"'
")
    result_logs "do_port_test" ${LOG_DO_PORT}  ${start_time} "${pub}"
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

do_port_test1
do_port_test2
do_port_test3
do_port_test4
do_port_test5
do_port_test6
do_port_test7

kill_process

