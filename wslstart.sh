#!/bin/bash

# this script (normally at /etc/wslstart.sh) will be executed by 
# /usr/sbin/wslstart as user root
#
# use 
# ln -sf `readlink -f wslstart.sh` /etc/wslstart.sh
# to create a softlink

FLAGF=/run/shm/wslstart.flag
WSLUSER=
WSLDEF=/etc/default/wslstart

if [ -r ${WSLDEF} ]
then
	# read $WSLUSER from $WSLDEF
	source ${WSLDEF}
fi

# /run/shm is tmpfs so it's clean when new WSL session starts
if [ ! -f ${FLAGF} ] 
then 
	# assume this is the first wslstart.sh instance of this WSL session
	echo "This is WSL session's first wslstart.sh instance, starting..."
	touch ${FLAGF}

	# use /run/shm as /tmp so we don't have to clean it up
	mount --bind /run/shm /tmp

	# we need this file so logout() does not return error
	touch /var/run/utmp

	# if user has ~/.wslstart.sh, also run it as the user
	if [ -n "${WSLUSER}" -a -x /home/${WSLUSER}/.wslstart.sh ]
	then
		echo "Running .wslstart.sh of user [${WSLUSER}]..."
		sudo -u ${WSLUSER} /home/${WSLUSER}/.wslstart.sh
	fi
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

