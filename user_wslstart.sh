#!/bin/bash

# my .wslstart.sh, which is executed by wslstart as normal user
# this file should be at ~/.wslstart.sh

WSLUSER=$(whoami)

# for tightvncserver
if [ -x /usr/bin/tightvncserver ]
then
	mkdir -p /run/shm/${WSLUSER}-vnc
	if [ -f ~/.vnc/passwd ]
	then
		cp ~/.vnc/passwd /run/shm/${WSLUSER}-vnc/
	fi
	if [ -x ~/.vnc/xstartup ]
	then
		cp ~/.vnc/xstartup /run/shm/${WSLUSER}-vnc/
	fi
fi
