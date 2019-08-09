#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void din_device_test1()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}","glp/0/17q2d9v/rq/dev/iox/meter/if/di/1");
	
	sub_start("glp/0/./=logger/event");
}

void din_device_test2()
{
	pub_start("{\r\n\"di-val\": {\r\n\"value\": {\r\n\"type\": \"level\",\r\n\"di-level\": {\r\n\"report-dur\":1000,\r\n\"detect-level\":0,\r\n\"pullup-cfg\":true\r\n},\r\n\r\n\"di-pulse\": {\r\n\"report-dur\":10,\r\n\"detect-level\":0,\r\n\"pullup-cfg\":true\r\n},\r\n\r\n\"di-frequency\": {\r\n\"report-dur\":100,\r\n\"detect-level\":0,\r\n\"pullup-cfg\":true\r\n}\r\n},\r\n\"monitor\": {\r\n\"rate\":1500,\r\n\"cat\":\"data\",\r\n\"inFeedback\":false,\r\n\"report\":\"change\",\r\n\"throttle\":0,\r\n\"threshold\":10\r\n}\r\n}\r\n\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/1");	

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/1");
	sub_start("glp/0/./=logger/event");
}


void main()
{
	din_device_test1();
	din_device_test2();
}
