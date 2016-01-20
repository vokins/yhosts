@echo off
Setlocal enabledelayedexpansion
::CODER BY Kwok POWERD BY iBAT
TAKEOWN /F "%windir%\System32\drivers\etc" /A
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f
rem icacls "%windir%\System32\drivers\etc" /grant "NT AUTHORITY\NetworkService":RX
copy /y "%~dp01A.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
exit