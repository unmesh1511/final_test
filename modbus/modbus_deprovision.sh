#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_DEPROV=${IOX_PATH}"/modbus/modbus_deprov_log"
MODB_TYPE="9FF4A2150040DB00"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/pm820/sts" > ${LOG_STS} 
}

#Deprovision before create
modbus_deprovision_test1()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 2
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${DEV_NOT_FOUND}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_deprovision_test" ${LOG_MODBUS_DEPROV}  ${start_time} "${pub}"
}

#Deprovision before provision
modbus_deprovision_test2()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t  "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do" 
	parse_logger "${DEPROV_UNSUCCESSFUL}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t  '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_deprovision_test" ${LOG_MODBUS_DEPROV}  ${start_time} "${pub}"
}

#Deprovision after provision
modbus_deprovision_test3()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_deprovision_test" ${LOG_MODBUS_DEPROV}  ${start_time} "${pub}"
}

#Deprovision again
modbus_deprovision_test4()
{
	start_time=$(date | awk '{print $4}') 
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 5
	parse_logger "${DEPROV_UNSUCCESSFUL}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_deprovision_test" ${LOG_MODBUS_DEPROV}  ${start_time} "${pub}"
}

#Deprovision after delete
modbus_deprovision_test5()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 2
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 5
	parse_logger "${DEV_NOT_FOUND}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_deprovision_test" ${LOG_MODBUS_DEPROV}  ${start_time} "${pub}"
}

setup_time

modbus_deprovision_test1
modbus_deprovision_test2
modbus_deprovision_test3
modbus_deprovision_test4
modbus_deprovision_test5

kill_process

