#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dcm/logger"
LOG_STS=${IOX_PATH}"/dcm/sts"
LOG_DCM_DEPROVISION=${IOX_PATH}"/dcm/dcm_deprovision_log"

dcm_deprovision_test1()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_sub -t "glp/0/${SID}/fb/con/test11/sts" > ${STS_PATH} &	
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/con/test11/do"
	parse_sts "${FAILED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/con/test11/do"'")
	result_logs "dcm_deprovision_test" ${LOG_DCM_DEPROVISION}  ${start_time} "${pub}"
}

dcm_deprovision_test2()
{
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/con/test0/do"

}

dcm_deprovision_test3()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_sub -t "glp/0/${SID}/fb/con/test2/sts" > ${STS_PATH}  &
	pids+=($!)
	mosquitto_sub -t "glp/0/${SID}/fb/con/test2/cfg" &
	pids+=($!)
	mosquitto_pub -m '{"action":"deprovision"}' -t "glp/0/${SID}/rq/con/test2/do"
	parse_sts "${UNPROVISION_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"deprovision"}' -t '"glp/0/${SID}/rq/con/test2/do"'")
	result_logs "dcm_deprovision_test" ${LOG_DCM_DEPROVISION}  ${start_time} "${pub}"
}

dcm_deprovision_test1
dcm_deprovision_test2
dcm_deprovision_test3

kill_process

