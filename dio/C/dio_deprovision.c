#include <stdio.h>
#include <pub.h>
#include <sub.h>
#include <jsonp.h>
#include <iox_error.h>

void dio_deprovision_test1()
{
	pub_start("{\r\n \"action\": \"deprovision\"\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void dio_deprovision_test2()
{
	pub_start("{\r\n \"action\": \"deprovision\"\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/17q3jbh/fb/dev/iox/sys/sts");
	sub_start("glp/0/./=logger/event");

}

void dio_deprovision_test3()
{
	pub_start("{\r\n \"action\": \"deprovision\"\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/17q3jbh/fb/dev/iox/sys/sts");
	sub_start("glp/0/./=logger/event");
}

void dio_deprovision_test4()
{
	pub_start("{\r\n \"action\": \"deprovision\"\r\n}","glp/0/17q2d9v/rq/dev/iox/dio/do");
	sub_start("glp/0/17q3jbh/fb/dev/iox/sys/sts");
	sub_start("glp/0/./=logger/event");
}

void main()
{
	dio_deprovision_test1();
	dio_deprovision_test2();
	dio_deprovision_test3();
	dio_deprovision_test4();
}

