#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/logger"
LOG_STS=${IOX_PATH}"/dio/sts"
LOG_DIO_PROV=${IOX_PATH}"/dio/dio_provision_log"
DIO_UNID="${IOX_INSTALL_ID}.dio"

subscribe_sts_event()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/sts" > ${LOG_STS}
}

# Provision with no UNID after creating dio device
# Expected result: PASS
# Not useful

dio_provision_test1()
{
	start_time=$(date | awk '{print $4}')	
	subscribe_sts_event &
	pids+=($!)
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	parse_logger "${DEV_NOT_UNPROV}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision","args":{}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_provision_test" ${LOG_DIO_PROV}  ${start_time} "${pub}"

	# TODO: Cleanup device state
	# unprovision dio device.
	
	dev_deprovision "${DIO_DEV_NAME}"
}

# Provision with wrong UNID after creating dio device
# Expected result: PASS
# Not useful

dio_provision_test2()
{
	start_time=$(date | awk '{print $4}')	
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"abcd"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":"abcd"}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_provision_test" ${LOG_DIO_PROV}  ${start_time} "${pub}"

	dev_deprovision "${DIO_DEV_NAME}"
}	

# Provision with correct UNID after creating dio device
# Expected result: PASS

dio_provision_test3()
{
	start_time=$(date | awk '{print $4}')	
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"'${DIO_UNID}'"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":'"${DIO_UNID}"'}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_provision_test" ${LOG_DIO_PROV}  ${start_time} "${pub}"

	dev_deprovision "${DIO_DEV_NAME}"
}

# Provision over provision [with same/different UNID] after creating dio device

dio_provision_test4()
{
	start_time=$(date | awk '{print $4}')	
	subscribe_logger_event &
	pids+=($!)
	mosquitto_sub -t "glp/0/./=logger/event" > ${LOGGER_PATH} &
	mosquitto_pub -m '{"action":"provision","args":{"unid":"'${DIO_UNID}'"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	mosquitto_pub -m '{"action":"provision","args":{"unid":"'${DIO_UNID}'"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_logger "${DEV_NOT_UNPROV}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":'"${DIO_UNID}"'}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_provision_test" ${LOG_DIO_PROV}  ${start_time} "${pub}"

	dev_deprovision "${DIO_DEV_NAME}"
}

# Provision after deprovision

dio_provision_test5()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_provision_test" ${LOG_DIO_PROV}  ${start_time} "${pub}"

	dev_deprovision "${DIO_DEV_NAME}"
}

setup_time

dio_provision_test1
dio_provision_test2
dio_provision_test3
dio_provision_test4
dio_provision_test5

kill_process
