#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void din_deep_test1()
{
	pub_start("30", "glp/0/17q2d9v/rq/dev/iox/dio/if/dia/1/di-val/monitor/rate");
	sub_start("glp/0/./=logger/event");
	sub_start("glp/0/17q2d9v/ev/error");
}

void din_deep_test2()
{
	pub_start("30", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/1/di-vala/monitor/rate");
	sub_start("glp/0/./=logger/event");
}

void din_deep_test3()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"frequency\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":15,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":true,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/1");
}

void din_deep_test4()
{
	pub_start("'{\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":100,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":true,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n}'", "glp/0/17q3kc1/rq/dev/iox/dio/if/di/1/di-val");
	sub_start("glp/0/17q3kc1/fb/dev/iox/dio/if/di/1");
}

void din_deep_test5()
{
	pub_start("'{\"rate\":50}'", "glp/0/17q3kc1/rq/dev/iox/dio/if/di/1/di-val/monitor");
	sub_start("glp/0/17q3kc1/fb/dev/iox/dio/if/di/1");
}

void din_deep_test6()
{
	pub_start("30", "glp/0/17q3kc1/rq/dev/iox/dio/if/di/1/di-val/monitor/rate");

	sub_start("glp/0/17q3kc1/fb/dev/iox/dio/if/di/1");
}

void main()
{
	din_deep_test1();
	din_deep_test2();
	din_deep_test3();
	din_deep_test4();
	din_deep_test5();
	din_deep_test6();
}
