# wslstart
Start WSL (Windows Subsystem for Linux)

wslstart is a simple Linux process running in WSL (Windows Subsystem for Linux) for automatically starting some tasks and services.

wslstart should be a SUID process so it has root priviledge (which is required by running system tasks and services).

When it starts, wslstart tries to run /etc/wslstart.sh script (in which user can start tasks they want).
Eariler versions of WSL kills init and all its child-processes when the last WSL console closes, so wslstart has to stay running to keep sshd alive. However, the recent versions of WSL does not kill init anymore, wslstart can quit after it starts wslstart.sh.

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
