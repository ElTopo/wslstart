# wslstart
Start WSL (Windows Subsystem for Linux)

wslstart is a simple Linux process running in WSL (Windows Subsystem for Linux) for automatically starting some tasks and services.

wslstart should be a SUID process so it has root priviledge (which is required by running system tasks and services).

When it starts, wslstart tries to run /etc/init.d/wslstart.sh script, then gets into long sleep to keep WSL system running.

To build:
```
gcc -o wslstart wslstart.c
```

To install:
```
sudo cp wslstart /usr/sbin/wslstart
sudo chown root:root /usr/sbin/wslstart
sudo chmod +s /usr/sbin/wslstart
```

To run (from Windows' cmd console):
```
bash -c "/usr/sbin/wslstart"
```
or run wslstart.cmd 
