#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/logger"
LOG_STS=${IOX_PATH}"/dio/sts"
LOG_DIO_DELETE=${IOX_PATH}"/dio/dio_delete_log"


subscribe_sts_event()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/sts" > ${LOG_STS}
}

#Delete before provision

dio_delete_test1()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_logger "${CANNOT_DEL}"
	parse_sts "${UNPROVISION_STATE}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_delete_test" ${LOG_DIO_DELETE} ${start_time} "${pub}"
}

#Delete after provision

dio_delete_test2()
{
	start_time=$(date | awk '{print $4}')
	dev_provision "${DIO_DEV_NAME}"
	subscribe_logger_event &
	pids+=($!)
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do" 
	parse_logger "${CANNOT_DEL}"
	parse_sts "${PROVISION_STATE}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_delete_test" ${LOG_DIO_DELETE} ${start_time} "${pub}"
}

#Delete after deprovision

dio_delete_test3()
{
	start_time=$(date | awk '{print $4}')
	dev_deprovision "${DIO_DEV_NAME}"
	subscribe_logger_event &
	pids+=($!)
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_logger "${CANNOT_DEL}"
	parse_sts "${UNPROVISION_STATE}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_delete_test" ${LOG_DIO_DELETE} ${start_time} "${pub}"
}

#Delete again

dio_delete_test4()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_logger "${CANNOT_DEL}"
	parse_sts "${UNPROVISION_STATE}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_delete_test" ${LOG_DIO_DELETE} ${start_time} "${pub}"
}

setup_time

dio_delete_test1
dio_delete_test2
dio_delete_test3
dio_delete_test4

kill_process

