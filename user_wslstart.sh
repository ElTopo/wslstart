# my .wslstart.sh
# this file should be at ~/.wslstart.sh

USER=lxl

# for tightvncserver
if [ -x /usr/bin/tightvncserver ]
then
	mkdir -p /run/shm/${USER}-vnc
	if [ -f ~/.vnc/passwd ]
	then
		cp ~/.vnc/passwd /run/shm/${USER}-vnc/
	fi
fi
