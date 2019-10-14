#!/bin/bash -x

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_CREATE=${IOX_PATH}"/modbus/modbus_create_log"
MODB_TYPE="9FF4A2150040DB00"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/pm820/sts" > ${LOG_STS} 
}

#Create without type

modbus_create_test1()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create"}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "${ERR_MOD_CREATE}"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create"}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

#Create with incorrect  type

modbus_create_test2()
{
    start_time=$(date | awk '{print $4}')
    subscribe_logger_event &
    pids+=($!)
    mosquitto_pub -m '{"action":"create","args":{"type":"ABCDEFG"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
    parse_logger
	result "logger"
    pub=("mosquitto_pub -m '{"action":"create","args":{"type":"ABCDEFG"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
    result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

#Create with correct type

modbus_create_test3()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 10
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"${MODB_TYPE}"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

modbus_create_test4()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	sleep 10
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"${MODB_TYPE}"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

#Create again on same handle but different type

modbus_create_test5()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"900000000000DB00"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "900000000000DB00 : type not found"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"900000000000DB00"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

modbus_create_test6()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/new_device.0/sts" > ${LOG_STS} &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/new_device.0/do"
	sleep 10
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"${MODB_TYPE}"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/new_device.0/do"'")
	result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

modbus_create_test7()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'","provision":"true"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "provision : unid missing"
    result "logger"
    pub=("mosquitto_pub -m '{"action":"create","args":{"type":"${MODB_TYPE}","provision":"true"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
    result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

modbus_create_test8()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'","provision":"false","unid":"01:43"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"${MODB_TYPE}","provision":"false","unid":"01:43"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

modbus_create_test9()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'","provision":"true","unid":"abcd"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "provision : unid missing"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"${MODB_TYPE}","provision":"true","unid":"abcd"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

modbus_create_test10()
{
	start_time=$(date | awk '{print $4}')
	subscribe_logger_event &
	pids+=($!)
#	mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/pm820/cfg" &
#	pids+=($!)
#	mosquitto_sub -t "glp/0/${SID}/fb/res/type/blk.900014150040DB00/0" &
#	pids+=($!)
#	mosquitto_sub -t "glp/0/${SID}/fb/dev/${MODBUS_PROTOCOL}/pm820/if/block/0" &
#	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"'${MODB_TYPE}'","provision":"true","unid":"01:1"}}' -t "glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"
	parse_logger "provision : unid missing"
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"${MODB_TYPE}","provision":"true","unid":"01:1"}}' -t '"glp/0/${SID}/rq/dev/${MODBUS_PROTOCOL}/pm820/do"'")
	result_logs "modbus_create_test" ${LOG_MODBUS_CREATE}  ${start_time} "${pub}"
}

setup_time

modbus_create_test1
modbus_create_test2
modbus_create_test3
modbus_create_test4
modbus_create_test5
modbus_create_test6
modbus_create_test7
modbus_create_test8
modbus_create_test9
modbus_create_test10

kill_process
