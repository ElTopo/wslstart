#!/bin/bash

# my .wslstart.sh, which is executed by wslstart as normal user
# this file should be at ~/.wslstart.sh

WSLUSER=$(whoami)
VNCUSERDIR=/run/shm/${WSLUSER}-vnc

# for tightvncserver
if [ -x /usr/bin/tightvncserver ]
then
	mkdir -p $VNCUSERDIR
	if [ -f ~/.vnc/passwd ]
	then
		cp ~/.vnc/passwd $VNCUSERDIR
	fi
	if [ -x ~/.vnc/xstartup ]
	then
		cp ~/.vnc/xstartup $VNCUSERDIR
	fi
fi
