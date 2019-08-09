#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void din_port_test1()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}\r\n", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/1");

	sub_start("glp/0/./=logger/event");
}

void din_port_test2()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}\r\n", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/2");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/2");
	sub_start("glp/0/./=logger/event");
}

void din_port_test3()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/3");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/3");
}

void din_port_test4()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}\r\n", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/4");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/4");
}

void din_port_test5()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}\r\n", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/5");
	
	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/5");
}

void din_port_test6()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/6");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/6");
}

void din_port_test7()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}\r\n", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/7");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/7");
}

void din_port_test8()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/8");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/8");
}

void din_port_test9()
{
	pub_start("{\r\n  \"di-val\": {\r\n     \"value\": {\r\n    \"type\": \"level\",\r\n      \"di-level\": {\r\n        \"report-dur\":1000,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-pulse\": {\r\n        \"report-dur\":10,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      },  \r\n\r\n      \"di-frequency\": {\r\n        \"report-dur\":100,\r\n        \"detect-level\":0, \r\n        \"pullup-cfg\":true\r\n      }\r\n      },  \r\n      \"monitor\":        {\r\n        \"rate\":1500,\r\n        \"cat\":\"data\",\r\n        \"inFeedback\":false,\r\n        \"report\":\"change\",\r\n        \"throttle\":0,\r\n        \"threshold\":10\r\n      }   \r\n  }\r\n\r\n}\r\n", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/10");

	sub_start("glp/0/17q2d9v/fb/dev/iox/dio/if/di/10");
}

void main()
{
	din_port_test1();
	din_port_test2();
	din_port_test3();
	din_port_test4();
	din_port_test5();
	din_port_test6();
	din_port_test7();
	din_port_test8();
	din_port_test9();
}
