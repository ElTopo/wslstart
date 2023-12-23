@rem lxlstartup.cmd:
@rem   for Windows 11's WSL2 with systemd enabled
@rem   executed when a user logging in
@rem   this file, or its shortcut, should be in the user's StartUp folder: 
@rem   (%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup)

@rem use smaller window
@mode con:cols=66 lines=10
@set PROMPT=#

@rem start putty pageant
@set PUTTYDIR=%USERPROFILE%\WinUtils\puttyall
@set KEYDIR=%USERPROFILE%\WinUtils\puttyall\Keys
@start /b %PUTTYDIR%\PAGEANT.EXE %KEYDIR%\mykey.ppk

@rem trigger wsl using execmd of nircmd (https://www.nirsoft.net/utils/nircmd.html)
@rem   "nircmd execmd" runs a cmd with hidden cmd window
@rem   "wsl ~" starts WSL session and stays there to avoid WSL's automatic stop
@set NIRCMD=%USERPROFILE%\WinUtils\nircmd\NirCmd.exe
@start /b %NIRCMD% execmd wsl ~

@rem more tasks to start at login...
