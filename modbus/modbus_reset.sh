#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_RESET=${IOX_PATH}"/modbus/modbus_reset_log"
MODB_TYPE="9FF4A2150040DB00"

modbus_reset_test1()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    sleep 10
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"reset"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${RESET_NOT_FOUND}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"reset"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_reset_test" ${LOG_MODBUS_RESET}  ${start_time} "${pub}"
}

modbus_reset_test1

kill_process

