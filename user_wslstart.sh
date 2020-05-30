#!/bin/bash

# my ~/.wslstart.sh, which is executed by wslstart as normal user
# this file should be soft-linked to ~/.wslstart.sh

# get WSL's IP(s)
WSLIP_FILE="/mnt/c/Users/lxl/wslip.txt"

# get WSL's all IPs
IPS=$(hostname -I)

if [ -z "$IPS" ] ; then 
	echo "Failed to get WSL's IP! quit."
else
	echo "WSL's IP(s): $IPS."
fi
echo "$IPS" > ${WSLIP_FILE}

# for tightvncserver
WSLUSER=$(whoami)
VNCUSERDIR=/run/shm/${WSLUSER}-vnc
DOTVNCDIR=~/.vnc

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
