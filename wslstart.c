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
		printf("press Ctrl+C to quit.\n");

		for (;;)
			sleep(3600);
	}

	// run wslstart.sh script
	system("/etc/wslstart.sh");

	for (int tmout = 10; tmout > 0; tmout--) {
		if (tmout == 1) {
			printf("\rwslstart will quit in %d second... \b", tmout);
		} else {
			printf("\rwslstart will quit in %d seconds... \b", tmout);
		}
		fflush(stdout);
		sleep((tmout > 0) ? 1 : 0);
	}
	printf("\n");
}

