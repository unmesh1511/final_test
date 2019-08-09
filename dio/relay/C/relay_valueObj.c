#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void relay_valueObj_test1()
{
	pub_start("{\r\n\"relay-val\": {\r\n            \"value\": {\r\n            \"level\": false\r\n              }       \r\n         }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/relay/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/relay/2");
}

void main()
{
	relay_valueObj_test1();
}
