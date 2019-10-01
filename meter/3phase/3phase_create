#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/meter/3phase/logger"
LOG_STS=${IOX_PATH}"/meter/3phase/sts"
LOG_3PHASE_CREATE=${IOX_PATH}"/meter/3phase/3phase_create_log"
METER_UNID="${IOX_INSTALL_ID}.meter"

subscribe_sts_event()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/sts" > ${LOG_STS}
}

#Create without type

3phase_create_test1()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create"}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create"}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create with incorrect type

3phase_create_test2()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"ABCDEFG"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"ABCDEFG"}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create with correct type but no unid

3phase_create_test3()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"meter"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"meter"}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create again on same handle with same type but no unid

3phase_create_test4()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"meter"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"meter"}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create again on same handle but different type and no unid

3phase_create_test5()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"ABCDEFG"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"ABCDEFG"}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create with provision flag true but no unid

3phase_create_test6()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"meter","provision":true}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/amik_1/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"meter","provision":true}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/amik_1/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create with provision true but incorrect unid

3phase_create_test7()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"meter","provision":true,"unid":"abcd"}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"meter","provision":true,"unid":"abcd"}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create with provision true but provision value is in string and correct unid

3phase_create_test8()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"type":"meter","provision":"true","unid":'"${METER_UNID}"'}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"type":"meter","provision":"true","unid":'"${METER_UNID}"'}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create with provision false but unid present

3phase_create_test9()
{
	start_time=$(date | awk '{print $4}')
	subscibe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"unid":'"${METER_UNID}"',"type":"meter","provision":false}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"unid":'"${METER_UNID}"',"type":"meter","provision":false}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

#Create with provision with a valid unid

3phase_create_test10()
{
	start_time=$(date | awk '{print $4}')
	subscibe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"create","args":{"unid":'"${METER_UNID}"',"type":"meter","provision":true}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"
	parse_logger
	result "logger"
	pub=("mosquitto_pub -m '{"action":"create","args":{"unid":'"${METER_UNID}"',"type":"meter","provision":true}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/do"'")
	result_logs "3phase_create_test" ${LOG_3PHASE_CREATE}  ${start_time} "${pub}"
}

setup_time

3phase_create_test1
3phase_create_test2
3phase_create_test3
3phase_create_test4
3phase_create_test5
3phase_create_test6
3phase_create_test7
3phase_create_test8
3phase_create_test9
3phase_create_test10

kill_process

