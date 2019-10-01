#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_STS=${IOX_PATH}"/dio/sts"
LOG_DIO_TEST=${IOX_PATH}"/dio/dio_test_log"


subscribe_sts_event()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/sts" > ${LOG_STS}
}

#Test before provision

dio_test_test1()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts ${UNPROVISION_STATE}
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_test_test" ${LOG_DIO_TEST}  ${start_time} "${pub}"
}

#Test after provision

dio_test_test2()
{
	start_time=$(date | awk '{print $4}')
	dev_provision "${DIO_DEV_NAME}"
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts ${PROVISION_STATE}
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_test_test" ${LOG_DIO_TEST}  ${start_time} "${pub}"
	dev_deprovision "${DIO_DEV_NAME}"
}

#Test after deprovision

dio_test_test3()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"test"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts ${UNPROVISION_STATE}
	result "sts"
	pub=("mosquitto_pub -m '{"action":"test"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_test_test" ${LOG_DIO_TEST}  ${start_time} "${pub}"
}

setup_time

dio_test_test1
dio_test_test2
dio_test_test3

kill_process
