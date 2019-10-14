#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_PROV=${IOX_PATH}"/modbus/modbus_prov_log"
MODB_TYPE="9FF4A2150040DB00"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/pm820/sts" > ${LOG_STS} 
}

#Provision before create
modbus_provision_test1()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 2
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "pm820 : device not found"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_provision_test" ${LOG_MODBUS_PROV}  ${start_time} "${pub}"
}

#Provision with no unid
modbus_provision_test2()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 10
	subscribe_logger_event &  
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${PROV_UNID_MISSING}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"provision","args":{}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_provision_test" ${LOG_MODBUS_PROV}  ${start_time} "${pub}"
}

#Provision with incorrect unid
modbus_provision_test3()
{
	start_time=$(date | awk '{print $4}')  
	subscribe_logger_event &  
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"3000"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${INVALID_UNID}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":"3000"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_provision_test" ${LOG_MODBUS_PROV}  ${start_time} "${pub}"
}

#Provision with already existing unid
modbus_provision_test4()
{
	start_time=$(date | awk '{print $4}')  
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 10
	parse_sts "provisioned"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_provision_test" ${LOG_MODBUS_PROV}  ${start_time} "${pub}"
}

#Provision with correct unid
modbus_provision_test5()
{
	start_time=$(date | awk '{print $4}')  
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":"01:1"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_provision_test" ${LOG_MODBUS_PROV}  ${start_time} "${pub}"
}

#Provision again with same/different unid
modbus_provision_test6()
{
	start_time=$(date | awk '{print $4}')  
	subscribe_logger_event &  
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"01:3"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":"01:3"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_provision_test" ${LOG_MODBUS_PROV}  ${start_time} "${pub}"
}

#Provision after deprovision
modbus_provision_test7()
{
	start_time=$(date | awk '{print $4}')  
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 2
	subscribe_sts_event &  
	pids+=($!)
	mosquitto_pub -m '{"action":"provision"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 10
	parse_sts "provisioned"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"provision"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_provision_test" ${LOG_MODBUS_PROV}  ${start_time} "${pub}"
}

#Provision after delete
modbus_provision_test8()
{
	start_time=$(date | awk '{print $4}')  
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 2
	subscribe_logger_event &  
	pids+=($!)
	mosquitto_pub -m '{"action":"provision","args":{"unid":"17"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 2
	parse_logger "pm820-device not found"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"provision","args":{"unid":"17"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_provision_test" ${LOG_MODBUS_PROV}  ${start_time} "${pub}"
}

setup_time

modbus_provision_test1
modbus_provision_test2
modbus_provision_test3
modbus_provision_test4
modbus_provision_test5
modbus_provision_test6
modbus_provision_test7
modbus_provision_test8

kill_process

