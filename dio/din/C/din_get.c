#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void din_get_test1()
{
	pub_start("{\r\n  \"corr\": \"abcd\",\r\n  \"response\": \"my/responses\",\r\n  \"item\": [\r\n    \"dev/iox.411b19/dio/if/di/1/di-val\"\r\n  ],\r\n  \"maxAge\": 1,\r\n  \"timeout\": 10\r\n}", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void din_get_test2()
{
	pub_start("{\r\n  \"corr\": \"abcd\",\r\n  \"response\": \"my/responses\",\r\n  \"item\": [\r\n    \"dev/iox.411b191212/dio/if/di/1/di-val\"\r\n  ],\r\n  \"maxAge\": 1,\r\n  \"timeout\": 10\r\n}", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void din_get_test3()
{
	pub_start("{\r\n  \"corr\": \"abcd\",\r\n  \"response\": \"my/responses\",\r\n  \"item\": [\r\n    \"dev/iox.411b19/dio/if/di/1/di-val\"\r\n  ],\r\n  \"maxAge\": 1,\r\n  \"timeout\": 10\r\n}", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void din_get_test4()
{
	pub_start("{\r\n  \"corr\": \"abcd\",\r\n  \"response\": \"my/responses\",\r\n  \"item\": [\r\n    \"dev/iox.411b19/dio/if/di/10/di-val\"\r\n  ],\r\n  \"maxAge\": 1,\r\n  \"timeout\": 10\r\n}", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void din_get_test5()
{
	pub_start("{\r\n  \"corr\": \"abcd\",\r\n  \"response\": \"my/responses\",\r\n  \"item\": [\r\n    \"dev/iox.411b19/dio/if/di/1/di-valasd\"\r\n  ],\r\n  \"maxAge\": 1,\r\n  \"timeout\": 10\r\n}", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void din_get_test6()
{
	pub_start("{\r\n  \"corr\": \"abcd\",\r\n  \"response\": \"my/responses\",\r\n  \"item\": [\r\n    \"dev/iox.411b19/dio/if/di/1/di-val\",\r\n    \"dev/iox.411b19/dio/if/di/2/di-val\"\r\n  ],\r\n  \"maxAge\": 1,\r\n  \"timeout\": 10\r\n}", "glp/0/./=get/dp/request");
	sub_start("my/responses");
}

void main()
{
	din_get_test1();
	din_get_test2();
	din_get_test3();
	din_get_test4();
	din_get_test5();
	din_get_test6();
}
