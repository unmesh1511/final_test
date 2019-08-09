#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void din_mode_test1()
{    
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":true,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/1");
	sub_start("glp/0/./=logger/event");
}

void din_mode_test2()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": false,\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":0,\r\n                \"duty-cycle\":0\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/relay/2");
	sub_start("glp/0/./=logger/event");
}

void din_mode_test3()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"level\",\r\n            \"level\": \"true\",\r\n            \"frequency\":0,\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/./=logger/event");
}

void din_mode_test4()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"pulse\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":15,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":true,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/1");
}

void din_mode_test5()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"pulse\",\r\n            \"level\": true,\r\n            \"frequency\"0,\r\n            \"pulse\": \"test\",\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/./=logger/event");
}

void din_mode_test6()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"frequency\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":15,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":true,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/1");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/1");
}

void din_mode_test7()
{
	pub_start("{\r\n\"do-val\": {\r\n            \"value\": {\r\n            \"type\": \"frequency\",\r\n            \"level\": true,\r\n            \"frequency\":\"test\",\r\n            \"pulse\": 0,\r\n            \"pwm\":{\r\n                \"frequency\":20000,\r\n                \"duty-cycle\":90\r\n               }\r\n             }\r\n       }\r\n}\r\n", "glp/0/17q2d9v/rq/dev/iox/dio/if/do/1");
	sub_start("glp/0/./=logger/event");
}

void main()
{
	din_mode_test1();
	din_mode_test2();
	din_mode_test3();
	din_mode_test4();
	din_mode_test5();
	din_mode_test6();
	din_mode_test7();
}
