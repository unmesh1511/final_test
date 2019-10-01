#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/meter/3phase/logger"
LOG_OUT=${IOX_PATH}"/meter/3phase/out"
LOG_3PHASE_PHASE_CONFIG=${IOX_PATH}"/meter/3phase/3phase_phase_config_log"

subscribe_phase()
{
	mosquitto_pub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0" -m '' -r
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0" > ${LOG_OUT}
}

parse_out()
{
	sleep 20
	rate=$(cat ${LOG_OUT} | python -c 'import sys, json;b=json.load(sys.stdin)["nvoVoltageRMS"];c=b["monitor"];d=c["rate"];print d')
#	echo "rate : "${rate}
	if [[ ${rate} -eq ${1} ]];
	then
		RESULT="PASS"
	else
		RESULT="FAIL"
	fi
	rm ${LOG_OUT}
}

3phase_deep_test1()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '30' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/dia/1/di-val/monitor/rate"
	parse_logger "${ERR_PARSE_JSON}"
	result "logger"
	pub=("mosquitto_pub -m '30' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/dia/1/di-val/monitor/rate"'")
	result_logs "3phase_phase_config_test" ${LOG_3PHASE_PHASE_CONFIG}  ${start_time} "${pub}"
}

3phase_deep_test2()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_pub -m '30' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/di-vala/monitor/rate"
}

3phase_deep_test3()
{
	start_time=$(date | awk '{print $4}')
	subscribe_phase &
	pids+=($!)
	mosquitto_pub -m '{"monitor":{"rate":100}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0/nvoVoltageRMS"
	parse_out 100
	echo "3phase_deep_test3 | RESULT : ${RESULT}"
	echo "=========================================================================================="
	unset RESULT rate
}

3phase_deep_test4()
{
	subscribe_phase &
	pids+=($!)
	mosquitto_pub -m '{"rate":100}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0/nvoVoltageRMS/monitor"
	parse_out 100
	echo "3phase_deep_test4 | RESULT : ${RESULT}"
	echo "=========================================================================================="
	unset RESULT rate
}

3phase_deep_test5()
{
	subscribe_phase &
	pids+=($!)
	mosquitto_pub -m '20' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0/nvoVoltageRMS/monitor/rate"
	parse_out 20
	echo "3phase_deep_test5 | RESULT : ${RESULT}"
	echo "=========================================================================================="
	unset RESULT rate
}

3phase_deep_test1
3phase_deep_test2
3phase_deep_test3
3phase_deep_test4
3phase_deep_test5

kill_process

