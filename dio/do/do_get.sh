#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_DO_GET=${IOX_PATH}"/dio/do/do_get_log"
OUT=${IOX_PATH}"/dio/do/out"

subscribe()
{
	mosquitto_sub -t "my/responses/do/1/input" > ${OUT}	
}

do_get_test1()
{	
	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/do/1/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "corr"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "do_get_test" ${LOG_DO_GET}  ${start_time} "${pub}"
}

do_get_test2()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/'${IOX_PROTOCOL}'12/'${DIO_DEV_NAME}'/if/do/1/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	sleep 10
	parse_get "No get response received for the datapoint dev/${IOX_PROTOCOL}12/${DIO_DEV_NAME}/if/do/1/input"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/${IOX_PROTOCOL}12/${DIO_DEV_NAME}/if/do/1/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "do_get_test" ${LOG_DO_GET}  ${start_time} "${pub}"
}

do_get_test3()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'12/if/do/1/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "datapoint not found"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}12/if/do/1/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "do_get_test" ${LOG_DO_GET}  ${start_time} "${pub}"
}

do_get_test4()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/do/8/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "datapoint not found"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/8/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "do_get_test" ${LOG_DO_GET}  ${start_time} "${pub}"
}

do_get_test5()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/do/8/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "datapoint not found"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/8/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "do_get_test" ${LOG_DO_GET}  ${start_time} "${pub}"
}

do_get_test6()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/do/1/input","dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/do/2/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "corr"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/do/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/do/1/input","dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/do/2/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "do_get_test" ${LOG_DO_GET}  ${start_time} "${pub}"
}

do_get_test1
do_get_test2
do_get_test3
do_get_test4
do_get_test5
do_get_test6

sleep 10
kill_process

