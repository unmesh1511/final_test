#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/meter/3phase/logger"
LOG_OUT=${IOX_PATH}"/meter/3phase/out"
LOG_3PHASE_BLOCK=${IOX_PATH}"/meter/3phase/3phase_block_log"

phase_invalid="The phase asked for is not valid"


###########check timestamp and pass

setup()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0" > ${LOG_OUT} &
	if [[ -s ${LOG_OUT} ]];
	then
		out_last_time=$(awk -F "," '/mru/{print $NF}' ${LOG_OUT} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		rm ${LOG_OUT}
	fi
}

parse()
{
	sleep 5
	if [[ -s ${LOG_OUT} ]];
    then   
		echo "3phase_block_test2" >> ${LOG_3PHASE_BLOCK}
		cat ${LOG_OUT} >> ${LOG_3PHASE_BLOCK}
		out_time=$(awk -F "," '/mru/{print $NF}' ${LOG_OUT} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $1" "$2}')
		echo "3phase_block_test2 | RESULT : PASS | ${out_time}"
    else
		echo "3phase_block_test2 | RESULT : FAIL | NO OUTPUT"
	fi
	echo "=========================================================================================="

	rm ${LOG_OUT}
}

3phase_block_handle_test1()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0" > ${LOG_OUT} &
	mosquitto_pub -m '{"cpPhaseEnable":{"L1_Phase":1,"L2_Phase":1,"L3_Phase":1},"cpCtRatio":{"L1_ctRatio":{"multiplier":10},"L2_ctRatio":{"multiplier":10},"L3_ctRatio":{"multiplier":10}},"nvoVoltageRMS":{"monitor":{"rate":500,"cat":"data","inFeedback":false,"report":"change","throttle":21,"threshold":31}},"nvoVoltageAvg":{"monitor":{"rate":300,"cat":"data","inFeedback":false,"report":"change","throttle":21,"threshold":31}},"nvoCurrentRMS":{"monitor":{"rate":550,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoActiveEnergy":{"monitor":{"rate":250,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoReactEnergy":{"monitor":{"rate":300,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoAppEnergy":{"monitor":{"rate":350,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseActEnergy":{"monitor":{"rate":400,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseRctEnergy":{"monitor":{"rate":450,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseAppEnergy":{"monitor":{"rate":500,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPower":{"monitor":{"rate":550,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseActPwr":{"monitor":{"rate":600,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseReactPwr":{"monitor":{"rate":650,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseAppPwr":{"monitor":{"rate":700,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPowerStatus":{"monitor":{"rate":500,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseFrequency":{"monitor":{"rate":400,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/0"
	parse
}

3phase_block_handle_test2()
{
	start_time=$(date | awk '{print $4}')
  	subscribe_logger_event &
	pids+=($!)
	mosquitto_pub -m '{"cpPhaseEnable":{"L1_Phase":1,"L2_Phase":1,"L3_Phase":1},"cpCtRatio":{"L1_ctRatio":{"multiplier":10},"L2_ctRatio":{"multiplier":10},"L3_ctRatio":{"multiplier":10}},"nvoVoltageRMS":{"monitor":{"rate":500,"cat":"data","inFeedback":false,"report":"change","throttle":21,"threshold":31}},"nvoVoltageAvg":{"monitor":{"rate":300,"cat":"data","inFeedback":false,"report":"change","throttle":21,"threshold":31}},"nvoCurrentRMS":{"monitor":{"rate":550,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoActiveEnergy":{"monitor":{"rate":250,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoReactEnergy":{"monitor":{"rate":300,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoAppEnergy":{"monitor":{"rate":350,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseActEnergy":{"monitor":{"rate":400,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseRctEnergy":{"monitor":{"rate":450,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseAppEnergy":{"monitor":{"rate":500,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPower":{"monitor":{"rate":550,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseActPwr":{"monitor":{"rate":600,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseReactPwr":{"monitor":{"rate":650,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseAppPwr":{"monitor":{"rate":700,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPowerStatus":{"monitor":{"rate":500,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}},"nvoPhaseFrequency":{"monitor":{"rate":400,"cat":"data","inFeedback":false,"report":"change","throttle":22,"threshold":32}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${METER_DEV_NAME}/if/phase/1"
	parse_logger "${phase_invalid}"
	result "logger"
	pub=("")
	result_logs "3phase_block_test" ${LOG_3PHASE_BLOCK}  ${start_time} "${pub}"
}

#setup
3phase_block_handle_test2
3phase_block_handle_test1

kill_process

