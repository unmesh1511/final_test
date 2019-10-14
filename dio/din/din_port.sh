#!/bin/bash	

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/din/logger"
LOG_DIN_PORT=${IOX_PATH}"/dio/din/din_port_log"
OUT=${IOX_PATH}"/dio/din/out"

subscribe()
{
	mosquitto_sub -t glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/${1} > ${OUT}
}

din_port_test1()
{
	start_time=$(date | awk '{print $4}')
	get_time 1
	sleep 5
	subscribe 1 &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

din_port_test2()
{
	start_time=$(date | awk '{print $4}')
	get_time 2
	sleep 5
	subscribe 2 &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/2"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/2"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

din_port_test3()
{
	start_time=$(date | awk '{print $4}')
	get_time 3
	sleep 5
	subscribe 3 &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/3"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/3"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

din_port_test4()
{
	start_time=$(date | awk '{print $4}')
	get_time 4
	sleep 5
	subscribe 4 &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/4"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/4"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

din_port_test5()
{
	start_time=$(date | awk '{print $4}')
	get_time 5
	sleep 5
	subscribe 5 &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/5"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/5"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

din_port_test6()
{
	start_time=$(date | awk '{print $4}')
	get_time 6
	sleep 5
	subscribe 6 &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/6"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/6"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

din_port_test7()
{
	start_time=$(date | awk '{print $4}')
	get_time 7
	sleep 5
	subscribe 7 &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/7"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/7"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

din_port_test8()
{
	start_time=$(date | awk '{print $4}')
	get_time 8
	sleep 5
	subscribe 8 &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/8"
	parse_out
	result
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/8"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

din_port_test9()
{
	start_time=$(date | awk '{print $4}')
	setup_time
	sleep 5
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/10"
	parse_logger "The port asked for is not valid"
	result "logger"
    pub=("mosquitto_pub -m '{"input":{"monitor":{"rate":50,"cat":"data","inFeedback":true,"report":"change","throttle":0,"threshold":10}},"mode":{"value":{"type":"level","level":{"detect-level":0,"pullup-cfg":true},"pulse":{"detect-level":0,"pullup-cfg":true},"frequency":{"detect-level":0,"pullup-cfg":true}}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/10"'
")
    result_logs "din_port_test" ${LOG_DIN_PORT}  ${start_time} "${pub}"
}

get_time()
{
	subscribe ${1} &
	pids+=($!)
	#get mru and store it in last_time 
	if [[ -s ${OUT} ]];
	then
		last_time=$(awk -F "," '/mru/{print $NF}' ${OUT} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		rm ${OUT}
	fi
}

din_port_test1
din_port_test2
din_port_test3
din_port_test4
din_port_test5
din_port_test6
din_port_test7
din_port_test8
din_port_test9

kill_process

