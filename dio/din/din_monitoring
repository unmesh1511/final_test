#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

OUT=${IOX_PATH}"/dio/din/out"

subscribe()
{
	mosquitto_sub -t "glp/0/./=monitoring/service" > ${OUT}
}

parse_out()
{
	if [[ -s ${OUT} ]];
	then
		port=$(tail -1  ${OUT} | python -c 'import sys, json; print json.load(sys.stdin)["topic"]' | xargs -Ireg echo reg > temp; awk -F '/' '{print $10}' temp; rm temp)
		echo "PORT : ${port}"
		if [[ ${port} -eq ${1} ]];
		then
			rate=$(tail -1 ${OUT} | python -c 'import sys, json; monitor=json.load(sys.stdin)["monitor"]; print monitor["rate"]')
			if [[ ${rate} -eq ${2} ]];
			then
				time=$(tail -1 ${OUT} | python -c 'import sys, json; print json.load(sys.stdin)["mru"]' | xargs -Itime echo time > temp; awk '{print $2}' temp; rm temp)
				echo "TIME : ${time}"
			fi
		fi
	else
		echo "EMPTY"	
	fi
}

din_monitoring()
{
	start_time=$(date | awk '{print $4}')
    subscribe &
    pids+=($!)
	mosquitto_pub -t "glp/0/${SID}/rq/dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input/monitor/rate" -m 40
	sleep 50
  	parse_out 1 40
	end_time=$(date | awk '{print $4}')
    exec_time=$(execution_time ${start_time} ${end_time})
#   echo "din_device_test1 | RESULT : ${RESULT} ${exec_time}"
    unset RESULT
	
}

din_monitoring

kill_process

