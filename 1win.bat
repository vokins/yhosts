@echo off
Setlocal enabledelayedexpansion
TAKEOWN /F "%windir%\System32\drivers\etc" /A
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f
rem icacls "%windir%\System32\drivers\etc" /grant "NT AUTHORITY\NetworkService":RX
copy /a pc.txt + grd.txt hbhosts.txt
copy /y "%~dp0hbhosts.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
del /f hbhosts.txt
exit