@echo off
Setlocal enabledelayedexpansion
TAKEOWN /F "%windir%\System32\drivers\etc" /A
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f
rem icacls "%windir%\System32\drivers\etc" /grant "NT AUTHORITY\NetworkService":RX
copy /y "%~dphosts.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
exit
