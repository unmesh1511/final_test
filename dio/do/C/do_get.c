#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void do_get_test1()
{	
	pub_start("{\r\n\"corr\": \"abcd\",\r\n\"response\": \"my/responses\",\r\n\"item\": [\r\n\"dev/iox.411b19/dio/if/do/1/do-val\"\r\n],\r\n\"maxAge\": 1,\r\n\"timeout\": 10\r\n}\r\n", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void do_get_test2()
{
	pub_start("{\r\n\"corr\": \"abcd\",\r\n\"response\": \"my/responses\",\r\n\"item\": [\r\n\"dev/iox.411b19/dio/if/do/1/do-val\"\r\n],\r\n\"maxAge\": 1,\r\n\"timeout\": 10\r\n}\r\n", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void do_get_test3()
{
	pub_start("{\r\n\"corr\": \"abcd\",\r\n\"response\": \"my/responses\",\r\n\"item\": [\r\n\"dev/iox.411b19/dio/if/do/1/do-val\"\r\n],\r\n\"maxAge\": 1,\r\n\"timeout\": 10\r\n}\r\n", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void do_get_test4()
{
	pub_start("{\r\n\"corr\": \"abcd\",\r\n\"response\": \"my/responses\",\r\n\"item\": [\r\n\"dev/iox.411b19/dio/if/do/1/do-val\"\r\n],\r\n\"maxAge\": 1,\r\n\"timeout\": 10\r\n}\r\n", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void do_get_test5()
{	
	pub_start("{\r\n\"corr\": \"abcd\",\r\n\"response\": \"my/responses\",\r\n\"item\": [\r\n\"dev/iox.411b19/dio/if/do/1/do-val\"\r\n],\r\n\"maxAge\": 1,\r\n\"timeout\": 10\r\n}\r\n", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void do_get_test6()
{
	pub_start("{\r\n\"corr\": \"abcd\",\r\n\"response\": \"my/responses\",\r\n\"item\": [\r\n\"dev/iox.411b19/dio/if/do/1/do-val\",\r\n\"dev/iox.411b19/dio/if/do/2/do-val\"\r\n],\r\n\"maxAge\": 1,\r\n\"timeout\": 10\r\n}\r\n", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void main()
{
	do_get_test1();
	do_get_test2();
	do_get_test3();
	do_get_test4();
	do_get_test5();
	do_get_test6();

}
