#!/bin/bash

# this script (/etc/init.d/wslstart.sh) will be executed by /usr/sbin/wslstart
# use 
# ln -sf this_file /etc/init.d/wslstart.sh
# to create a softlink

FLAGF=/run/shm/wslstart.flag

# /run/shm is tmpfs so it's clean when new WSL session starts
if [ ! -f $FLAGF ] 
then 
	# assume this is the first wslstart instance of this WSL session
	echo "This is WSL session's first wslstart instance."
	touch $FLAGF

	# use /run/shm as /tmp so we don't have to clean it up
	mount --bind /run/shm /tmp

	# we need this file so logout() does not return error
	touch /var/run/utmp
else
	echo "This is NOT WSL session's first instance of wslstart."
fi

# start some service(s)
SSHDPID=$(pgrep sshd)
if [ -n "$SSHDPID" ]
then
	echo "sshd is already running" 
else
	service ssh restart
fi
