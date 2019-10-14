#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/do/logger"
LOG_STS=${IOX_PATH}"/dio/do/sts"
LOG_DO_MODE=${IOX_PATH}"/dio/do/do_mode_log"
OUT=${IOX_PATH}"/dio/do/out"

subscribe()
{
    mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1" > ${OUT}
}

do_mode_test1()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":true,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test2()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test3()
{
	start_time=$(date | awk '{print $4}')
	setup_time
	sleep 5
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":12,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_logger " Wrong configuration for level "
	result "logger"
    pub=("mosquitto_pub -m '{"output":{"value":{"level":12,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"level"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test4()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":1000,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"pulse"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":1000,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"pulse"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test5()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":60000,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"pulse"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":60000,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"pulse"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test6()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":"test","pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"pulse"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_logger " Wrong configuration for Pulse "
	result "logger"
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":0,"pulse_counter":{"Pulse_pwm":{"pulse":"test","pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"pulse"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test7()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"frequency"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"frequency"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test8()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":20000,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"frequency"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":20000,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"frequency"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test9()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":"1","pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"frequency"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_logger " Wrong configuration for Freque"
	result "logger"
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":"1","pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":0,"duty_cycle":0}}}}},"mode":{"value":{"type":"frequency"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test10()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":1,"duty_cycle":10}}}}},"mode":{"value":{"type":"pwm"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":1,"duty_cycle":10}}}}},"mode":{"value":{"type":"pwm"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test11()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":20000,"duty_cycle":90}}}}},"mode":{"value":{"type":"pwm"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":20000,"duty_cycle":90}}}}},"mode":{"value":{"type":"pwm"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test12()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":"1","duty_cycle":10}}}}},"mode":{"value":{"type":"pwm"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_logger "Wrong configuration for PWM Fr"
	result "logger"
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":"1","duty_cycle":10}}}}},"mode":{"value":{"type":"pwm"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
}

do_mode_test13()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":1,"duty_cycle":"10"}}}}},"mode":{"value":{"type":"pwm"}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"
	parse_logger "Wrong configuration for PWM Du"
	result "logger"
    pub=("mosquitto_pub -m '{"output":{"value":{"level":false,"frequency":1,"pulse_counter":{"Pulse_pwm":{"pulse":0,"pwm":{"frequency":1,"duty_cycle":"10"}}}}},"mode":{"value":{"type":"pwm"}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1"'
")
    result_logs "do_mode_test" ${LOG_DO_MODE}  ${start_time} "${pub}"
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

do_mode_test1
do_mode_test2
do_mode_test3
do_mode_test4
do_mode_test5
do_mode_test6
do_mode_test7
do_mode_test8
do_mode_test9
do_mode_test10
do_mode_test11
do_mode_test12
do_mode_test13

kill_process

