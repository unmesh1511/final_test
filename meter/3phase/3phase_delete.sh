#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/meter/3phase/logger"
LOG_STS=${IOX_PATH}"/meter/3phase/sts"
LOG_3PHASE_DEL=${IOX_PATH}"/meter/3phase/3phase_delete_log"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/sts" > ${STS_PATH} 
}


3phase_delete_test1()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger "Built-in Meter Device can not be deleted"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_delete_test" ${LOG_3PHASE_DEL}  ${start_time} "${pub}"
}

3phase_delete_test2()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger "Built-in Meter Device can not be deleted"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_delete_test" ${LOG_3PHASE_DEL}  ${start_time} "${pub}"
}

3phase_delete_test3()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger "Built-in Meter Device can not be deleted"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_delete_test" ${LOG_3PHASE_DEL}  ${start_time} "${pub}"
}

3phase_delete_test4()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger "Built-in Meter Device can not be deleted"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_delete_test" ${LOG_3PHASE_DEL}  ${start_time} "${pub}"
}

setup_time

3phase_delete_test1
3phase_delete_test2
3phase_delete_test3
3phase_delete_test4

kill_process

