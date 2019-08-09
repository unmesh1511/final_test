#include <stdio.h>
#include <pub.h>
#include <sub.h>
#include <jsonp.h>
#include <iox_error.h>

void dio_load_test1()
{
	pub_start("{\r\n \"action\": \"load\"\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/17q3jbh/fb/dev/iox/sys/sts");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void main()
{
	dio_load_test1();
}

