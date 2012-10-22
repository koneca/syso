
#include <stdio.h>
#include <sys/sysinfo.h>
#include <unistd.h>     // sysconf

int main() {
	struct sysinfo info;
	sysinfo(&info);

	printf("Hello Kernel World\n");
	printf("Uptime: %lu\n", info.uptime);
	printf("Total RAM: %lu MB\n", info.totalram/1024/1024);
	printf("Free RAM: %lu MB\n", info.freeram/1024/1024);
	printf("Process count: %d\n", info.procs);
	printf("Page size: %li\n", sysconf(_SC_PAGESIZE));
	printf("Going to sleep for 5secs\n");
		usleep (5000000);
	return 0;
}
