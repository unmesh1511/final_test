#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_TEST=${IOX_PATH}"/modbus/modbus_test_log"
MODB_TYPE="9FF4A2150040DB00"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/pm820/sts" > ${LOG_STS} 
}

#Test before create
modbus_test_test1()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 2
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${DEV_NOT_FOUND}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_test_test" ${LOG_MODBUS_TEST}  ${start_time} "${pub}"
}

#Test before provision
modbus_test_test2()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_test_test" ${LOG_MODBUS_TEST}  ${start_time} "${pub}"
}

#Test after provision
modbus_test_test3()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 5
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_test_test" ${LOG_MODBUS_TEST}  ${start_time} "${pub}"
}

#Test again when slave is down
modbus_test_test4()
{
	start_time=$(date | awk '{print $4}') 
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_test_test" ${LOG_MODBUS_TEST}  ${start_time} "${pub}"
}

#Test after deprovision
modbus_test_test5()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 2
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_test_test" ${LOG_MODBUS_TEST}  ${start_time} "${pub}"
}

#Test after delete
modbus_test_test6()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 2
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 2
	parse_logger "${DEV_NOT_FOUND}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_test_test" ${LOG_MODBUS_TEST}  ${start_time} "${pub}"
}

setup_time

modbus_test_test1
modbus_test_test2
modbus_test_test3
modbus_test_test4
modbus_test_test5
modbus_test_test6

kill_process

