#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"

LOG_EVENT_LOGGER=${IOX_PATH}"/modbus/logger"
LOG_STS=${IOX_PATH}"/modbus/sts"
LOG_MODBUS_REPAIR=${IOX_PATH}"/modbus/modbus_repair_log"

modbus_deep_test1()
{
	start_time=$(date | awk '{print $4}') 
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"Voltage_A-B":{"monitor":{"rate":10}}}' -t "glp/0/17q2d9v/rq/dev/iox/dummy/if/block/7"
	parse_logger "Voltage_A-B : datapoint not found"
	result "logger"
	pub=("mosquitto_pub -m '{"Voltage_A-B":{"monitor":{"rate":10}}}' -t '"glp/0/17q2d9v/rq/dev/iox/dummy/if/block/7"'")
	result_logs "modbus_repair_test" ${LOG_MODBUS_REPAIR}  ${start_time} "${pub}"
}

modbus_deep_test2()
{
	start_time=$(date | awk '{print $4}') 	
	subscribe_logger_event & 
	pids+=($!)
	mosquitto_pub -m '{"dummy":{"monitor":{"rate":10}}}' -t "glp/0/17q2d9v/rq/dev/iox/dummy/if/block/1"
	parse_logger "dummy : datapoint not found"
	result "logger"
	pub=("mosquitto_pub -m '{"dummy":{"monitor":{"rate":10}}}' -t '"glp/0/17q2d9v/rq/dev/iox/dummy/if/block/1"'")
	result_logs "modbus_repair_test" ${LOG_MODBUS_REPAIR}  ${start_time} "${pub}"
}
	
modbus_deep_test3()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_sub -t "glp/0/17q2d9v/fb/dev/iox/pm820/if/block/1" &
	pids+=($!)
	mosquitto_pub -m '{"Voltage_A-B":{"monitor":{"rate":10}}}' -t "glp/0/17q2d9v/rq/dev/iox/pm820/if/block/1"
}

modbus_deep_test4()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_sub -t "glp/0/17q2d9v/fb/dev/iox/pm820/if/block/1" &
	pids+=($!)
	mosquitto_pub -m '{"monitor":{"rate":20}}' -t "glp/0/17q2d9v/rq/dev/iox/pm820/if/block/1/Voltage_A-B"
}

modbus_deep_test5()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_sub -t "glp/0/17q2d9v/fb/dev/iox/pm820/if/block/1" &
	pids+=($!)
	mosquitto_pub -m '{"rate":30}' -t "glp/0/17q2d9v/rq/dev/iox/pm820/if/block/1/Voltage_A-B/monitor" 
}

modbus_deep_test6()
{
	start_time=$(date | awk '{print $4}') 
	mosquitto_sub -t "glp/0/17q2d9v/fb/dev/iox/pm820/if/block/1" &
	pids+=($!)
	mosquitto_pub -m '40' -t "glp/0/17q2d9v/rq/dev/iox/pm820/if/block/1/Voltage_A-B/monitor/rate"
}

modbus_deep_test1
modbus_deep_test2
modbus_deep_test3
modbus_deep_test4
modbus_deep_test5
modbus_deep_test6

kill_process

