#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void do_device_test1()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":10,\r\n            \"pulse\": 300,\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/if/do/1");
	sub_start("glp/0/./=logger/event");
}

void do_device_test2()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":10,\r\n            \"pulse\": 300,\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/1");
}

void main()
{
	do_device_test1();
	do_device_test2();
}
