#include <stdio.h>
#include <pub.h>
#include <sub.h>
#include <jsonp.h>
#include <iox_error.h>

void result(int rc)
{
	switch (rc) {
		case 0:
			printf("FAILED\n");
			break;
		case 1:
			printf("PASSED\n");
			break;
		case -1:
			printf("unable to parse\n");
			break;
	}
}

void dio_create_test1()
{
	pub_start("{\r\n \"action\": \"create\"\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	result(parser(msg_copy, ERR_PARSE_ARGS));
	sub_start("glp/0/17q3jbh/fb/dev/iox/sys/sts");
}

void dio_create_test2()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"900001050304DD00\"\r\n }\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	result(parser(msg_copy, ERR_NO_UNIT_ID));
}

void dio_create_test3()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"900001050304DD00\"\r\n }\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	result(parser(msg_copy, ERR_NO_UNIT_ID));
}

void dio_create_test4()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"900001050304DD00\"\r\n }\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	result(parser(msg_copy, ERR_NO_UNIT_ID));
}

void dio_create_test5()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"900001050304DD00\"\r\n }\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	result(parser(msg_copy, ERR_NO_UNIT_ID));
}

void dio_create_test6()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"900001050304DD00\",\r\n \"provision\": true\r\n }\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	result(parser(msg_copy, ERR_NO_UNIT_ID));
}

void dio_create_test7()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"900001050304DD00\",\r\n \"provision\": false,\r\n \"unid\": \"256\"\r\n }\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
}

void dio_create_test8()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"900001050304DD00\",\r\n \"provision\": true,\r\n \"unid\": \"abcd\"\r\n }\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	result(parser(msg_copy, ERR_DEVICE_CREATE));
}

void dio_create_test9()
{
	pub_start("{\r\n \"action\": \"create\",\r\n \"args\": {\r\n \"type\": \"900001050304DD00\",\r\n \"provision\": \"true\",\r\n \"unid\": \"256\"\r\n }\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	result(parser(msg_copy, ERR_INVALID_PROVISION));
}

void main()
{
	dio_create_test1();
	dio_create_test2();
	dio_create_test3();
	dio_create_test4();
	dio_create_test5();
	dio_create_test6();
	dio_create_test7();
	dio_create_test8();
	dio_create_test9();
}
