#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dcm/logger"
LOG_STS=${IOX_PATH}"/dcm/sts"
LOG_DCM_DELETE=${IOX_PATH}"/dcm/dcm_delete_log"

dcm_delete_test1()
{
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/con/test0/do"
}

dcm_delete_test2()
{	

	start_time=$(date | awk '{print $4}')
	mosquitto_sub -t "glp/0/${SID}/fb/con/test1/sts" > ${STS_PATH} &
	pids+=($!)
	mosquitto_sub -t "glp/0/${SID}/fb/con/test1/cfg" &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/con/test1/do"
	parse_sts "${DELETED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/con/test1/do"'")
	result_logs "dcm_delete_test" ${LOG_DCM_DELETE}  ${start_time} "${pub}"
}

dcm_delete_test3()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_sub -t "glp/0/${SID}/fb/con/test0/sts" > ${STS_PATH} &
	pids+=($!)
	mosquitto_sub -t "glp/0/${SID}/fb/con/test0/cfg" &
	pids+=($!)
	mosquitto_pub -m '{"action":"delete"}' -t "glp/0/${SID}/rq/con/test0/do"
	parse_sts "${DELETED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"delete"}' -t '"glp/0/${SID}/rq/con/test0/do"'")
	result_logs "dcm_delete_test" ${LOG_DCM_DELETE}  ${start_time} "${pub}"
}

dcm_delete_test1
dcm_delete_test2
dcm_delete_test3

kill_process

