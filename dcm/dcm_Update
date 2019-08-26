#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dcm/logger"
LOG_STS=${IOX_PATH}"/dcm/sts"
LOG_DCM_UPDATE=${IOX_PATH}"/dcm/dcm_update_log"

dcm_update_test1()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_sub -t "glp/0/${SID}/fb/con/test1/sts" > ${STS_PATH} &
	pids+=($!)
	mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/meter/if/phase/0/nvoCurrentRMS/value"],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/do/2/do-val123/value"],"policy":"smart","map":{"frequency":"$.L1_current"}}}' -t "glp/0/${SID}/rq/con/test1/do"
	parse_sts "${FAILED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/meter/if/phase/0/nvoCurrentRMS/value"],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/do/2/do-val123/value"],"policy":"smart","map":{"frequency":"$.L1_current"}}}' -t '"glp/0/${SID}/rq/con/test1/do"'")
	result_logs "dcm_update_test" ${LOG_DCM_UPDATE}  ${start_time} "${pub}"
}

dcm_update_test2()
{	
	mosquitto_pub -m '{"action":"update","args":{"sources":[],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/do/2/do-val/value"],"policy":"smart","map":{"frequency":"$.L1_current"}}}' -t "glp/0/${SID}/rq/con/test1/do"

}

dcm_update_test3()
{
	mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/meter/if/phase/0/nvoCurrentRMS/value"],"destinations":[],"policy":"smart","map":{"frequency":"$.L1_current"}}}' -t "glp/0/${SID}/rq/con/test1/do"
}

dcm_update_test4()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_sub -t "glp/0/${SID}/fb/con/test0/sts" > ${STS_PATH} &
	pids+=($!)
	mosquitto_sub -t "glp/0/${SID}/fb/con/test0/cfg" &
	pids+=($!)
	mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/meter/if/phase/0/nvoCurrentRMS/value"],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/do/2/do-val/value"],"policy":"smart","map":{"frequency":"$.L1_current"}}}' -t "glp/0/${SID}/rq/con/test0/do"
	parse_sts
	result "sts"
	pub=("mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/meter/if/phase/0/nvoCurrentRMS/value"],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/do/2/do-val/value"],"policy":"smart","map":{"frequency":"$.L1_current"}}}' -t '"glp/0/${SID}/rq/con/test0/do"'")
	result_logs "dcm_update_test" ${LOG_DCM_UPDATE}  ${start_time} "${pub}"
}

dcm_update_test1
dcm_update_test2
dcm_update_test3
dcm_update_test4

kill_process


