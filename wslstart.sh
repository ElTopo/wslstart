#!/bin/bash

### BEGIN INIT INFO
# Provides:		wslstart
# Required-Start:	$local_fs
# Required-Stop:	$local_fs
# Default-Start:	2 3 4 5
# Default-Stop:
# Short-Description:	WSL starter
### END INIT INFO

# this script (/etc/init.d/wslstart.sh) will be executed by /usr/sbin/wslstart
# use 
# ln -sf `readlink -f wslstart.sh` /etc/init.d/wslstart.sh
# to create a softlink

FLAGF=/run/shm/wslstart.flag

# /run/shm is tmpfs so it's clean when new WSL session starts
if [ ! -f $FLAGF ] 
then 
	# assume this is the first wslstart.sh instance of this WSL session
	echo "This is WSL session's first wslstart.sh instance."
	touch $FLAGF

	# use /run/shm as /tmp so we don't have to clean it up
	mount --bind /run/shm /tmp

	# we need this file so logout() does not return error
	touch /var/run/utmp
else
	echo "This is NOT WSL session's first wslstart.sh instance."
fi

# start some service(s)
SSHDPID=$(pgrep sshd)
if [ -n "$SSHDPID" ]
then
	echo "sshd is already running" 
else
	service ssh restart
fi

