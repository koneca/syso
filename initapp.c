
#include <sys/sysinfo.h>
#include <stdio.h>

int main() {
	struct sysinfo info;
	sysinfo(&info);
	
	printf("Hello Kernel World\n");
	printf("Uptime: %lu\n", info.uptime);
	printf("Total RAM: %lu\n", info.totalram);
	printf("Free RAM: %lu\n", info.freeram);
	printf("Process count: %d\n", info.procs);
	printf("Page size: %d\n", info.mem_unit);
	return 0;
}
