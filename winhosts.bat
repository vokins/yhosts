@echo off
Setlocal enabledelayedexpansion
::CODER BY Kwok POWERD BY iBAT
if exist %ComSpec% (set e=%windir%\system32\drivers\etc&set h=%windir%\system32\drivers\etc\hosts) Else (set e=%windir%&set h=%windir%\hosts)
echo y|CACLS %windir%\system32\drivers\etc\hosts /c /p everyone:f
copy %~dp0hosts.txt" %h%
rem copy "%~dp0hosts.txt" "%SystemRoot%\System32\drivers\etc\hosts"
ipconfig -flushdns >nul 2>nul
ipconfig -registerdns
ipconfig -renew
ipconfig /flushdns
exit