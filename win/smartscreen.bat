
cd /d %~dp0
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit

set qx="c:\Windows\System32\smartscreen.exe"
takeown /f %qx% && icacls %qx% /grant administrators:F
icacls %qx% /deny Everyone:(S,X)
pause