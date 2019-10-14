#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_REPLACE=${IOX_PATH}"/modbus/modbus_replace_log"
MODB_TYPE="9FF4A2150040DB00"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/pm820/sts" > ${LOG_STS} 
}

#Replace without new unid
modbus_replace_test1()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"replace"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${INVALID_UNID}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"replace"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_replace_test" ${LOG_MODBUS_REPLACE}  ${start_time} "${pub}"
}

#Replace with already used unid
modbus_replace_test2()
{
	start_time=$(date | awk '{print $4}') 
	subscribe_sts_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"replace","args":{"unid":"01:43"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "unprovisioned"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"replace","args":{"unid":"01:43"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_replace_test" ${LOG_MODBUS_REPLACE}  ${start_time} "${pub}"
}

#Replace with incorrect unid
modbus_replace_test3()
{
	start_time=$(date | awk '{print $4}') 
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"replace","args":{"unid":1000}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${INVALID_UNID}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"replace","args":{"unid":1000}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_replace_test" ${LOG_MODBUS_REPLACE}  ${start_time} "${pub}"
}

#Replace with same unid
modbus_replace_test4()
{
	start_time=$(date | awk '{print $4}') 
	subscribe_sts_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"replace","args":{"unid":"01:1"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "unprovisioned"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"replace","args":{"unid":"01:1"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_replace_test" ${LOG_MODBUS_REPLACE}  ${start_time} "${pub}"
}

#Replace with new unid
modbus_replace_test5()
{
	start_time=$(date | awk '{print $4}') 
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"replace","args":{"unid":"01:2"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "unprovisioned"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"replace","args":{"unid":"01:2"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_replace_test" ${LOG_MODBUS_REPLACE}  ${start_time} "${pub}"
}

setup_time

modbus_replace_test1
modbus_replace_test2
modbus_replace_test3
modbus_replace_test4
modbus_replace_test5

kill_process

