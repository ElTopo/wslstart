#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
	// check if I am running as root
	if ((setuid(0) == -1) || (setgid(0) == -1)) {
		printf("wslstart is not running as 'root'! wslstart.sh might not work correctly.\n");
		printf("fix this by 'chown root:root wslstart && chmod +s wslstart'.\n");
	}

	// run wslstart.sh script
	system("/etc/init.d/wslstart.sh");

	// if wslstart.sh exits, get into sleep
	printf("wslstart now is running... press Ctrl+C to quit.\n");

	for (;;)
		sleep(3600);
}

