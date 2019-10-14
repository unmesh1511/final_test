#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/dio/relay/logger"
LOG_STS=${IOX_PATH}"/dio/relay/sts"
LOG_RELAY_VALUEOBJ=${IOX_PATH}"/dio/relay/relay_valueobj_log"
OUT=${IOX_PATH}"/dio/relay/out"

subscribe()
{
	mosquitto_sub -t "glp/0/${SID}/fb/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1" > ${OUT}
}

relay_valueObj_test1()
{
	start_time=$(date | awk '{print $4}')
  	subscribe &
	pids+=($!)
	mosquitto_pub -m '{"relay-val":{"value":{"level":false}}}' -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1"
	parse_out
	result
	pub=("mosquitto_pub -m '{"relay-val":{"value":{"level":false}}}' -t '"glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/relay/1"'")
	result_logs "relay_valueObj_test" ${LOG_RELAY_VALUEOBJ}  ${start_time} "${pub}"
}

get_time()
{
	subscribe &
	pids+=($!)
	#get mru and store it in last_time 
	if [[ -s ${OUT} ]];
	then
		out_last_time=$(awk -F "," '/mru/{print $NF}' ${OUT} | grep -oP '[[:digit:]].*(?= [[:space:]]*UTC.*)' | sort -k1,2 -ur | head -n1 | awk '{print $2}')
		rm ${OUT}
	fi
}

get_time 

relay_valueObj_test1

sleep 10

kill_process

