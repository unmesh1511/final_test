#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

modbus_get_test1()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/'${IOX_PROTOCOL}'/pm820/if/block/1/Voltage_A-B"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"

}

modbus_get_test2()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/'${IOX_PROTOCOL}'/dummy/if/block/1/Voltage_A-B"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"

}

modbus_get_test3()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/'${IOX_PROTOCOL}'/pm820/if/block/100/Voltage_A-B"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"

}

modbus_get_test4()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/'${IOX_PROTOCOL}'/pm820/if/block/1/dummy"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"

}

modbus_get_test5()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/'${IOX_PROTOCOL}'/pm820/if/block/1/Voltage_A-B"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"

}

modbus_get_test6()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/'${IOX_PROTOCOL}'/pm820/if/block/1/Voltage_A-B","dev/'${IOX_PROTOCOL}'/pm820/if/block/1/Voltage_B-C"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"

}

modbus_get_test1
modbus_get_test2
modbus_get_test3
modbus_get_test4
modbus_get_test5
modbus_get_test6
sleep 10
kill_process
