#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_LOAD=${IOX_PATH}"/modbus/modbus_load_log"

modbus_load_test1()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"load"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${LOAD_NOT_FOUND}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"load"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_load_test" ${LOG_MODBUS_LOAD}  ${start_time} "${pub}"
}

modbus_load_test1

kill_process

