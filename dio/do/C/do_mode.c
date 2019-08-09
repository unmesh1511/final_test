#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void do_mode_test1()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");

	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void do_mode_test2()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": false,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/relay/2");
}

void do_mode_test3()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": \"true\",\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void do_mode_test4()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"pulse\",\r\n            \"level\": false,\r\n            \"frequency\":0,\r\n            \"pulse\": 1000,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/1");
}

void do_mode_test5()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"pulse\",\r\n            \"level\": false,\r\n            \"frequency\":0,\r\n            \"pulse\": 60000,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/1");
}

void do_mode_test6()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"pulse\",\r\n            \"level\": true,\r\n            \"frequency\"0,\r\n            \"pulse\": \"test\",\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void do_mode_test7()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"frequency\",\r\n            \"level\": false,\r\n            \"frequency\":1,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/1");
}

void do_mode_test8()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"frequency\",\r\n            \"level\": false,\r\n            \"frequency\":20000,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/1");
}

void do_mode_test9()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"frequency\",\r\n            \"level\": true,\r\n            \"frequency\":\"test\",\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void do_mode_test10()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"pwm\",\r\n            \"level\": false,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":1,\r\n                \"duty-cycle\":10\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/1");
}

void do_mode_test11()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"pwm\",\r\n            \"level\": false,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/1");
}

void do_mode_test12()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"pwm\",\r\n            \"level\": true,\r\n            \"frequency\"0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":\"test\",\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void do_mode_test13()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"pwm\",\r\n            \"level\": true,\r\n            \"frequency\"0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":\"test\",\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void main()
{
	do_mode_test1();
	do_mode_test2();
	do_mode_test3();
	do_mode_test4();
	do_mode_test5();
	do_mode_test6();
	do_mode_test7();
	do_mode_test8();
	do_mode_test9();
	do_mode_test10();
	do_mode_test11();
	do_mode_test12();
	do_mode_test13();

}
