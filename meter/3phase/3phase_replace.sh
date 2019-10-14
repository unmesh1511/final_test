#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/meter/3phase/logger"
LOG_STS=${IOX_PATH}"/meter/3phase/sts"
LOG_3PHASE_REPLACE=${IOX_PATH}"/meter/3phase/3phase_replace_log"

3phase_replace_test1()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"replace"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger "${UNSUPPORTED_ACT}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"replace"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_replace_test" ${LOG_3PHASE_REPLACE}  ${start_time} "${pub}"
}

3phase_replace_test1

kill_process

