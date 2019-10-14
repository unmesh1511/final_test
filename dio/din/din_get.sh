#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/info_file.sh"
source ${IOX_PATH}"/errors.sh"

LOG_DIN_GET=${IOX_PATH}"/dio/din/din_get_log"
OUT=${IOX_PATH}"/dio/din/out"

subscribe()
{
	mosquitto_sub -t "my/responses/di/1/input" > ${OUT}	
}

din_get_test1()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/di/1/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "corr"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "din_get_test" ${LOG_DIN_GET}  ${start_time} "${pub}"
}

din_get_test2()
{

	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/'${IOX_PROTOCOL}'2ee/'${DIO_DEV_NAME}'/if/di/1/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	sleep 10
	parse_get "No get response received for the datapoint dev/${IOX_PROTOCOL}2ee/${DIO_DEV_NAME}/if/di/1/input"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/${IOX_PROTOCOL}2ee/${DIO_DEV_NAME}/if/di/1/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "din_get_test" ${LOG_DIN_GET}  ${start_time} "${pub}"
}

din_get_test3()
{

	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'aww/if/di/1/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "datapoint not found"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}aww/if/di/1/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "din_get_test" ${LOG_DIN_GET}  ${start_time} "${pub}"
}

din_get_test4()
{

	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/di/1dfd/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "datapoint not found"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1dfd/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "din_get_test" ${LOG_DIN_GET}  ${start_time} "${pub}"
}

din_get_test5()
{

	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/di/1/inputasd"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "datapoint not found"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/inputasd"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "din_get_test" ${LOG_DIN_GET}  ${start_time} "${pub}"
}

din_get_test6()
{
	start_time=$(date | awk '{print $4}')
	subscribe &
 	pids+=($!)
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/di/1/input","dev/'${IOX_PROTOCOL}'/'${DIO_DEV_NAME}'/if/di/2/input"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
	parse_get "corr"
	result "get"
    pub=("mosquitto_pub -m '{"corr":"abcd","response":"my/responses/di/1/input","item":["dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/1/input","dev/${IOX_PROTOCOL}/${DIO_DEV_NAME}/if/di/2/input"],"maxAge":1,"timeout":10}' -t '"glp/0/./=get/dp/request"'")
    result_logs "din_get_test" ${LOG_DIN_GET}  ${start_time} "${pub}"
}

din_get_test1
din_get_test2
din_get_test3
din_get_test4
din_get_test5
din_get_test6

sleep 10

kill_process

