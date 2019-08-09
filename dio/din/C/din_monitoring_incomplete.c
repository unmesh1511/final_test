#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void test1()
{
	pub_start("30", "glp/0/17q2d9v/rq/dev/iox/dio/if/dia/1/di-val/monitor/rate");
	sub_start("glp/0/./=monitoring/service");
	sub_start("glp/0/./=logger/event");
}

void main()
{
	test1();
}

