#include <stdio.h>
#include "my_pub.c"
#include "my_sub.c"

void 3phase_deep_test1()
{
	pub_start("30", "glp/0/17q2d9v/rq/dev/iox/dio/if/dia/1/di-val/monitor/rate");
	sub_start("glp/0/./=logger/event");
}

void 3phase_deep_test2()
{
	pub_start("30", "glp/0/17q2d9v/rq/dev/iox/dio/if/di/1/di-vala/monitor/rate");
	sub_start("glp/0/./=logger/event");
}

void 3phase_deep_test3()
{
	pub_start("{\"monitor\":{\"rate\" : 100}}", "glp/0/17q2d9v/rq/dev/iox/meter/if/phase/0/nvoVoltageRMS");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/if/phase/0");
}

void 3phase_deep_test4()
{
	pub_start("{\"rate\" : 100}", "glp/0/17q2d9v/rq/dev/iox/meter/if/phase/0/nvoVoltageRMS/monitor");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/if/phase/0");
}

void 3phase_deep_test5()
{
	pub_start("20", "glp/0/17q2d9v/rq/dev/iox/meter/if/phase/0/nvoVoltageRMS/monitor/rate");
	sub_start("glp/0/17q2d9v/fb/dev/iox/meter/if/phase/0");
}

void main()
{
	3phase_deep_test1();
	3phase_deep_test2();
	3phase_deep_test3();
	3phase_deep_test4();
	3phase_deep_test5();
}
