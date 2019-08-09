#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void 3phase_create_test1()
{
	pub_start("{\r\n \"action\": \"create\"\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test2()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"ABCDEFG\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test3()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"meter\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test4()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"meter\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test5()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"ABCDEFG\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test6()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"meter\",\r\n \"provision\": true\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/amik_1/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test7()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"meter\",\r\n \"provision\": true,\r\n \"unid\": \"abcd\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test8()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"meter\",\r\n \"provision\": \"true\",\r\n \"unid\": \"257\"\r\n }\r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test9()
{
	pub_start("{\r\n    \"action\":\"create\",\r\n    \"args\": {\r\n       \"unid\":\"257\",\r\n       \"type\":\"meter\",\r\n       \"provision\":false\r\n    }  \r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void 3phase_create_test10()
{
	pub_start("{\r\n    \"action\":\"create\",\r\n    \"args\": {\r\n       \"unid\":\"257\",\r\n       \"type\":\"meter\",\r\n       \"provision\":true\r\n    }  \r\n}", "glp/0/17q2d9v/rq/dev/iox/meter/do");
	sub_start("glp/0/./=logger/event");
}

void main()
{
	3phase_create_test1();
	3phase_create_test2();
	3phase_create_test3();
	3phase_create_test4();
	3phase_create_test5();
	3phase_create_test6();
	3phase_create_test7();
	3phase_create_test8();
	3phase_create_test9();
	3phase_create_test10();
}
