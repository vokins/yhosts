@echo off
Setlocal enabledelayedexpansion
::CODER BY Kwok POWERD BY iBAT
copy/b hosts.txt+mobile.txt android.txt
rem dos2unix.exe -n android.txt hosts
"%~dp0lib\dos2unix.exe" -n android.txt hosts
del android.txt
exit
