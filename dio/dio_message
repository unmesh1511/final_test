#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/logger"
LOG_STS=${IOX_PATH}"/dio/sts"
LOG_DIO_MSG=${IOX_PATH}"/dio/dio_msg_log"

dio_message_test1()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"message"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_logger "${ERR_MSG_HNDL}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"message"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_message_test" ${LOG_DIO_MSG}  ${start_time} "${pub}"
}

setup_time

dio_message_test1

kill_process
