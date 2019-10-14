#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/meter/3phase/logger"
LOG_STS=${IOX_PATH}"/meter/3phase/sts"
LOG_3PHASE_TEST=${IOX_PATH}"/meter/3phase/3phase_test_log"

subscribe_sts_event()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/sts" > ${LOG_STS}
}

3phase_test_test1()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_test_test" ${LOG_3PHASE_TEST}  ${start_time} "${pub}"
}

3phase_test_test2()
{
	start_time=$(date | awk '{print $4}')
	dev_provision "${DIO_DEV_NAME}"
  	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_sts ${PROVISION_STATE}
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_test_test" ${LOG_3PHASE_TEST}  ${start_time} "${pub}"
	dev_deprovision "${DIO_DEV_NAME}"
}

3phase_test_test3()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_sts ${UNPROVISION_STATE}
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_test_test" ${LOG_3PHASE_TEST}  ${start_time} "${pub}"
}

3phase_test_test4()
{
	start_time=$(date | awk '{print $4}')
	dev_delete "${METER_DEV_NAME}"  
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_test_test" ${LOG_3PHASE_TEST}  ${start_time} "${pub}"
	mosquitto_pub -m '{"action":"create"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
}

setup_time

3phase_test_test1
3phase_test_test2
3phase_test_test3
3phase_test_test4

kill_process
