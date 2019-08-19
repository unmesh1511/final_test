#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void 3phase_provision_test1()
{
	pub_start("{\r\n \"action\": \"provision\",\r\n \"args\": {\r\n \"unid\": \"256\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/sts");
}

void 3phase_provision_test2()
{
	pub_start("{\r\n \"action\": \"provision\",\r\n \"args\": { }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/sts");
}

void 3phase_provision_test3()
{
	pub_start("{\r\n \"action\": \"provision\",\r\n \"args\": {\r\n \"unid\": \"abcd\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/sts");
}

void 3phase_provision_test4()
{
	pub_start("{\r\n \"action\": \"provision\"\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/sts");
}

void 3phase_provision_test5()
{
	pub_start("{\r\n \"action\": \"provision\",\r\n \"args\": {\r\n \"unid\": \"257\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/sts");
}

void 3phase_provision_test6()
{
	pub_start("{\r\n \"action\": \"provision\"\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/sts");
}

void 3phase_provision_test7()
{
	pub_start("{\r\n \"action\": \"provision\"\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/sts");
}

void main()
{
	3phase_provision_test1();
	3phase_provision_test2();
	3phase_provision_test3();
	3phase_provision_test4();
	3phase_provision_test5();
	3phase_provision_test6();
	3phase_provision_test7();
}
