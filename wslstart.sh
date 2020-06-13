#!/bin/bash

# this script (normally at /etc/wslstart.sh) will be executed by 
# /usr/sbin/wslstart as user root
#
# use 
# ln -sf `readlink -f wslstart.sh` /etc/wslstart.sh
# to create a softlink

FLAGF=/run/shm/wslstart.flag
WSLDEF=/etc/default/wslstart

WSLUSER=
WSL1STTIME="false"

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
	WSL1STTIME="true"
	touch ${FLAGF}

	# clear /tmp
	cd /tmp && rm -rf `ls -Ab`

	# use /run/shm as /tmp so we don't have to clean it up
	mount --bind /run/shm /tmp

	# we need this file so logout() does not return error
	touch /var/run/utmp

	# run all scripts in /etc/wslstart.d as user 'root'
	if [ -d /etc/wslstart.d ]
	then
		for i in /etc/wslstart.d/*.sh
		do
			if [ -x $i ]
			then
				$i
			fi
		done
		unset i
	fi

	# if ${WSLUSER} has ~/.wslstart.sh, also run it as user ${WSLUSER}
	if [ -n "${WSLUSER}" -a -x /home/${WSLUSER}/.wslstart.sh ]
	then
		echo "Running .wslstart.sh of user [${WSLUSER}]..."
		sudo -u ${WSLUSER} /home/${WSLUSER}/.wslstart.sh
	fi
else
	echo "This is NOT WSL session's first wslstart.sh instance."
fi

# this part is always executed everytime wslstart invoked
# start some service(s)
# always check sshd service because it's crucial
SSHDPID=$(pgrep sshd)
if [ -n "$SSHDPID" ]
then
	echo "sshd is already running" 
else
	service ssh restart
fi
# always check cron service because it's crucial
CRONPID=$(pgrep cron)
if [ -n "$CRONPID" ]
then
	echo "cron is already running" 
else
	service cron restart
fi

