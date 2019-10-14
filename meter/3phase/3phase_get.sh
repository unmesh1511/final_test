#!/bin/bash

source env_var.sh
source ${IOX_PATH}"/common.sh"
source ${IOX_PATH}"/iox.config"
source ${IOX_PATH}"/errors.sh"



3phase_get_test1()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/iox/meter/if/phase/0/nvoPhaseFrequency"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
}

3phase_get_test2()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/iox/meter/if/phase/0/nvoPhaseFrequency"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
}

3phase_get_test3()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/iox/meterasd/if/phase/0/nvoPhaseFrequency"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
}

3phase_get_test4()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/iox/meter/if/phase/10/nvoPhaseFrequency"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
}

3phase_get_test5()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/iox/meter/if/phase/0/nvoPhaseFrequency_test"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
}

3phase_get_test6()
{
	mosquitto_sub -t "my/responses" &
	mosquitto_pub -m '{"corr":"abcd","response":"my/responses","item":["dev/iox/meter/if/phase/0/nvoPhaseFrequency","dev/iox/meter/if/phase/0/nvoVoltageRMS"],"maxAge":1,"timeout":10}' -t "glp/0/./=get/dp/request"
}

3phase_get_test1
3phase_get_test2	
3phase_get_test3
3phase_get_test4
3phase_get_test5
3phase_get_test6

kill_process
