@echo off
rem rebootwsl.cmd: reboot/restart WSL

rem shut down current running WSL
echo Shutting down WSL...
wsl.exe --shutdown

rem wait 8 seconds (according to https://learn.microsoft.com/en-us/windows/wsl/wsl-config)
timeout /t 8 /nobreak

rem update kernel if there's a new one
set NEWKERNEL=%USERPROFILE%\lxlwsl\lxl-newkernel
set KERNEL=%USERPROFILE%\lxlwsl\lxl-kernel
if not exist %NEWKERNEL% goto starting
echo Updating WSL kernel...
move /y %NEWKERNEL% %KERNEL%

@rem make sure in %USERPROFILE%\.wslconfig, set kernel= in [wsl2] section:
@rem   [wsl2]
@rem   kernel="c:\\Users\\lxl\\lxlwsl\\lxl-kernel"
@rem
@rem otherwise, the WSL's default kernel will be loaded

:starting
rem trigger wsl using execmd of nircmd (https://www.nirsoft.net/utils/nircmd.html)
echo Starting WSL...
set NIRCMD=%USERPROFILE%\WinUtils\nircmd\NirCmd.exe
start /b %NIRCMD% execmd wsl ~

