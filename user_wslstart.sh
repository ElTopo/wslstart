#!/bin/bash

# my ~/.wslstart.sh, which is executed by wslstart as normal user
# this file should be soft-linked to ~/.wslstart.sh

WSLUSER=$(whoami)
VNCUSERDIR=/run/shm/${WSLUSER}-vnc
DOTVNCDIR=~/.vnc

# for tightvncserver
if [ -x /usr/bin/tightvncserver ]
then
	mkdir -p $VNCUSERDIR
	if [ -f $DOTVNCDIR/passwd ]
	then
		cp $DOTVNCDIR/passwd $VNCUSERDIR
	fi
	if [ -x $DOTVNCDIR/xstartup ]
	then
		cp $DOTVNCDIR/xstartup $VNCUSERDIR
	fi
fi
