#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void relay_deep_test1()
{
	pub_start("true", "glp/0/17q2d9v/rq/dev/iox/dio/if/relay/1/relay-val/value/level12");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void relay_deep_test2()
{
	pub_start("true", "glp/0/17q2d9v/rq/dev/iox/dio/if/relay/1/relay-val/value/level");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/relay/1");
}

void main()
{
	relay_deep_test1();
	relay_deep_test2();
}
