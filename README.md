# wslstart

**Start WSL (Windows Subsystem for Linux)**

wslstart is a simple Linux process running in WSL (Windows Subsystem for Linux) for automatically starting some tasks and services.

**NOTE: wslstart was designed for Windows 10's WSL2 (that did not support systemd), for Windows 11's WSL2, it's better that you just enable systemd and use lxlstartup.cmd instead.**

wslstart should be a SUID process so it has root priviledge (which is required by running system tasks and services).

When it starts, wslstart tries to run /etc/wslstart.sh script (in which user can start tasks they want) and optionally ~user/.wslstart.sh script (define $WSLUSER in /etc/default/wslstart).
Eariler versions of WSL kills init and all its child-processes when the last WSL console closes, so wslstart has to stay running to keep sshd alive. However, the recent versions of WSL does not kill init anymore, wslstart can quit after it starts wslstart.sh.

NOTE: For Windows 11 and Server 2022, wslstart can be invoked by wsl.conf/[boot]/command
      so wslstart does not need to be owned by root. Unfortunately, for Windows 10 (which is 
	  what I am running), wslstart still needs +s, and is still useful.

To build:
```
make
```

To install:
```
make install
```

To uninstall:
```
make uninstall
```

To run (from Windows' cmd console):
```
wsl /usr/sbin/wslstart
```
or
```
bash -c "/usr/sbin/wslstart"
```
or copy wslstart.cmd to Windows' file system and run it from Windows.

To automatically run wslstart at Windows 10's boottime or user's log on time, the easiest way is using "Task Scheduler" to create a basic task to run wslstart.cmd. Note that wslstart.cmd can be started at anytime, it won't harm if it's started several times.
