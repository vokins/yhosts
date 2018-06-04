@echo off
setlocal enabledelayedexpansion
cls
echo 同步年代、日期、时间到本地电脑
::==============================================================
for /f "tokens=2,3 delims= " %%a in ('curl time.nist.gov:13') do (
set "riqi=%%a"
set "hh=1%%b"
set /a "h=(!hh:~0,3!%%100+8)%%24"
echo !riqi!
echo !h!!hh:~-6!
echo !riqi!|date
echo !h!!hh:~-6!|time
)
::==============================================================
exit

