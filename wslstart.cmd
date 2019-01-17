@echo off

@rem use smaller window
@mode con:cols=66 lines=6
@set PROMPT=# 

@rem old version: use bash.exe
@rem bash -c "/usr/sbin/wslstart"

@rem new version: use wsl.exe
@wsl /usr/sbin/wslstart

