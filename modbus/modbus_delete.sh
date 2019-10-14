#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_DEL=${IOX_PATH}"/modbus/modbus_del_log"
MODB_TYPE="9FF4A2150040DB00"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/pm820/sts" > ${LOG_STS} 
}

#Delete before create
modbus_delete_test1()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 2
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${DEV_NOT_FOUND}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_delete_test" ${LOG_MODBUS_DEL}  ${start_time} "${pub}"
}

#Delete before provision
modbus_delete_test2()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "${DELETED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_delete_test" ${LOG_MODBUS_DEL}  ${start_time} "${pub}"
}

#Delete after provision
modbus_delete_test3()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	subscribe_sts_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 5
	parse_sts "${DELETED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_delete_test" ${LOG_MODBUS_DEL}  ${start_time} "${pub}"
}

#Delete after deprovision
modbus_delete_test4()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
    mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "${DELETED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_delete_test" ${LOG_MODBUS_DEL}  ${start_time} "${pub}"
}

#Delete again
modbus_delete_test5()
{
	start_time=$(date | awk '{print $4}') 
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${DEV_NOT_FOUND}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_delete_test" ${LOG_MODBUS_DEL}  ${start_time} "${pub}"
}

setup_time

modbus_delete_test1
modbus_delete_test2
modbus_delete_test3
modbus_delete_test4
modbus_delete_test5

kill_process

