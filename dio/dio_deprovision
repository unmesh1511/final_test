#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/logger"
LOG_STS=${IOX_PATH}"/dio/sts"
LOG_DIO_DEPROVISION=${IOX_PATH}"/dio/dio_deprovision_log"


subscribe_sts_event()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/sts" > ${LOG_STS}
	pids+=($!)
}


#Deprovision before provision

dio_deprovision_test1()
{	
	start_time=$(date | awk '{print $4}')
 	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do" 
	parse_logger "${DEV_NOT_PROV}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_deprovision_test" ${LOG_DIO_DEPROVISION}  ${start_time} "${pub}"
}

#Deprovision after provision

dio_deprovision_test2()
{
	start_time=$(date | awk '{print $4}')
	dev_provision "${DIO_DEV_NAME}" 
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_deprovision_test" ${LOG_DIO_DEPROVISION}  ${start_time} "${pub}"
}

#Deprovision again

dio_deprovision_test3()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"
	parse_logger "${DEV_NOT_PROV}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/do"'")
	result_logs "dio_deprovision_test" ${LOG_DIO_DEPROVISION}  ${start_time} "${pub}"
}

setup_time

dio_deprovision_test1
dio_deprovision_test2
dio_deprovision_test3

kill_process
