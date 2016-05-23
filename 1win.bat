@echo off
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo.&Echo 请使用右键“以管理员身份运行”&&Pause >NUL&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
TAKEOWN /F %windir%\System32\drivers\etc >nul 2>nul
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f >nul 2>nul
copy /a "%~dp0hosts.txt" + "%~dp0grd.txt" "%~dp0hbhosts.txt" 
copy /y "%~dp0hbhosts.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
del /f "%~dp0hbhosts.txt"
start "" "%SystemRoot%\system32\notepad.exe" "%SystemRoot%\system32\drivers\etc\hosts"
exit