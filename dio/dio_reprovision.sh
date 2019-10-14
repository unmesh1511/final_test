#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/logger"
LOG_STS=${IOX_PATH}"/dio/sts"
LOG_DIO_PROV=${IOX_PATH}"/dio/dio_reprovision_log"
DIO_UNID="${IOX_INSTALL_ID}.dio"

subscribe_sts_event()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/sts" > ${LOG_STS}
}

cleanup_dio_testcase_1()
{
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
}

# Provision before creating DIO device
# Expected result : FAIL
dio_reprovision_test1()
{
	start_time=$(date | awk '{print $4}')	
	subscribe_sts_event &
	pids+=($!)
	cleanup_dio_testcase_1
	sleep 2
	mosquitto_pub -m '{"action":"provision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":'"${DIO_UNID}"'}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_provision_test" ${LOG_DIO_PROV}  ${start_time} "${pub}"
	
}

setup_time

dio_reprovision_test1

kill_process
