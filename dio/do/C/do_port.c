#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void do_port_test1()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/1");
}

void do_port_test2()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/2");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/2");
}

void do_port_test3()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/3");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/3");
}

void do_port_test4()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/4");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/4");
}

void do_port_test5()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/5");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/5");
}

void do_port_test6()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/6");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/6");
}

void do_port_test7()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": true,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/8");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/do/8");
}

void main()
{
	do_port_test1();
	do_port_test2();
	do_port_test3();
	do_port_test4();
	do_port_test5();
	do_port_test6();
	do_port_test7();
}
