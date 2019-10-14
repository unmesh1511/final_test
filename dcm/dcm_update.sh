#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dcm/logger"
LOG_STS=${IOX_PATH}"/dcm/sts"
LOG_DCM_UPDATE=${IOX_PATH}"/dcm/dcm_update_log"

subscribe_sts_event()
{
	 mosquitto_sub -t "glp/0/${SID}/fb/con/test20/sts" > ${STS_PATH} 
}

dcm_update_test1()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/dio/if/di/2/di-val/value"],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/relay/1/relay-val123/value"],"policy":"smart","map":{"level":"$.di-level.level"}}}' -t "glp/0/${SID}/rq/con/test20/do"
	parse_sts "${FAILED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/dio/if/di/2/di-val/value"],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/relay/1/relay-val123/value"],"policy":"smart","map":{"level":"$.di-level.level"}}}' -t '"glp/0/${SID}/rq/con/test20/do"'")
	result_logs "dcm_update_test" ${LOG_DCM_UPDATE}  ${start_time} "${pub}"
}

dcm_update_test2()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_pub -m '{"action":"update","args":{"sources":[],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/relay/1/relay-val/value"],"policy":"smart","map":{"level":"$.di-level.level"}}}' -t "glp/0/${SID}/rq/con/test20/do"
}

dcm_update_test3()
{
	start_time=$(date | awk '{print $4}')
	mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/dio/if/di/2/di-val/value"],"destinations":[],"policy":"smart","map":{"level":"$.di-level.level"}}}' -t "glp/0/${SID}/rq/con/test20/do"

}

dcm_update_test4()
{
	start_time=$(date | awk '{print $4}')
	subscribe_sts_event &
	pids+=($!)
	mosquitto_sub -t "glp/0/${SID}/fb/con/test20/cfg" &
	pids+=($!)
	mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/dio/if/di/2/di-val/value"],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/relay/2/relay-val/value"],"policy":"smart","map":{"level":"$.di-level.level"}}}' -t "glp/0/${SID}/rq/con/test20/do"
	parse_sts "${UPDATED_STATE}"
	result "sts"
	pub=("mosquitto_pub -m '{"action":"update","args":{"sources":["glp/0/${SID}/fb/dev/iox/dio/if/di/2/di-val/value"],"destinations":["glp/0/${SID}/rq/dev/iox/dio/if/relay/2/relay-val/value"],"policy":"smart","map":{"level":"$.di-level.level"}}}' -t '"glp/0/${SID}/rq/con/test20/do"'")
	result_logs "dcm_update_test" ${LOG_DCM_UPDATE}  ${start_time} "${pub}"
}

dcm_update_test1
dcm_update_test2
dcm_update_test3
dcm_update_test4

kill_process

