@echo off
@rem You can change this window's default size by going to 
@rem System menu -> Defaults -> Layout -> Window Size: Width 66, Height 6.
@mode con:cols=70 lines=6
@set PROMPT=# 

@bash -c "/usr/sbin/wslstart"
