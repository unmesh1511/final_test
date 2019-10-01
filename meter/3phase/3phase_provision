#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/meter/3phase/logger"
LOG_STS=${IOX_PATH}"/meter/3phase/sts"
LOG_3PHASE_PROVISION=${IOX_PATH}"/meter/3phase/3phase_provision_log"
DIO_UNID="${IOX_INSTALL_ID}.dio"
METER_UNID="${IOX_INSTALL_ID}.meter"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/sts" > ${LOG_STS} 
}

#Provision with no unid

3phase_provision_test1()
{
	start_time=$(date | awk '{print $4}')
	dev_deprovision "${METER_DEV_NAME}"
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision","args":{}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_provision_test" ${LOG_3PHASE_PROVISION}  ${start_time} "${pub}"
	dev_deprovision "${METER_DEV_NAME}"
}

#Provision with incorrect unid

3phase_provision_test2()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"abcd"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":"abcd"}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_provision_test" ${LOG_3PHASE_PROVISION}  ${start_time} "${pub}"
	dev_deprovision "${METER_DEV_NAME}"
}

#Provision with correct unid

3phase_provision_test3()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_provision_test" ${LOG_3PHASE_PROVISION}  ${start_time} "${pub}"
	dev_deprovision "${METER_DEV_NAME}"
}

#Provision again with same/different unid

3phase_provision_test4()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":'"${METER_UNID}"'}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_sts "${UNPROVISION_STATE}"
	parse_logger "${DEV_ALREADY_PROV}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":'"${METER_UNID}"'}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_provision_test" ${LOG_3PHASE_PROVISION}  ${start_time} "${pub}"
	dev_deprovision "${METER_DEV_NAME}"
}

#Provision after deprovision

3phase_provision_test5()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_sts "${PROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_provision_test" ${LOG_3PHASE_PROVISION}  ${start_time} "${pub}"
	dev_deprovision "${METER_DEV_NAME}"
}

#Provision after delete

3phase_provision_test6()
{
	start_time=$(date | awk '{print $4}')
	dev_delete "${METER_DEV_NAME}" 
 	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger "Built-in Meter Device can not be deleted"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"provision"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_provision_test" ${LOG_3PHASE_PROVISION}  ${start_time} "${pub}"
}

setup_time

3phase_provision_test1
3phase_provision_test2
3phase_provision_test3
3phase_provision_test4
3phase_provision_test5
3phase_provision_test6

kill_process

