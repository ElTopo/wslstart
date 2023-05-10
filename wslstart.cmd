@echo off
goto :init

:usage
  @echo Usage: wslstart.cmd [reboot^|shutdown^|help]
  @echo          reboot: shutdown the default WSL session before start it
  @echo          shutdown: shutdown the default WSL session and quit
  @echo          help: print usage and quit
  @echo          no parameters: just start the default WSL session normally
  @goto :exit

:shutdown 
  @rem shutdown and quit
  @echo Shutting down WSL...
  @wsl --shutdown
  @timeout /nobreak 8
  @goto :exit
  
:reboot
  @rem shutdown and continue
  @echo Rebooting WSL...
  @wsl --shutdown
  @timeout /nobreak 8
  @goto :start

:init
  @if "%1"=="help" goto :usage
  @if "%1"=="shutdown" goto :shutdown
  @if "%1"=="reboot" goto :reboot
  @if "%1"=="" goto :start
  @goto :usage

:start
  @rem use smaller window
  @mode con:cols=66 lines=10
  @set PROMPT=#

  @rem start putty pageant
  @set PUTTYDIR=%HOMEDRIVE%%HOMEPATH%\WinUtils\puttyall
  @set KEYDIR=%HOMEDRIVE%%HOMEPATH%\WinUtils\puttyall\Keys
  @start /b %PUTTYDIR%\PAGEANT.EXE %KEYDIR%\mykey.ppk

  @rem execute wslstart, which executes /etc/wslstart.sh
  @wsl /usr/sbin/wslstart
  
:exit
