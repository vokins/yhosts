@ECHO OFF
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
TITLE п╤ть OneDrive
taskkill /f /im OneDrive.exe > NUL 2>&1
%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall
rd /s /q "%UserProfile%\OneDrive" > NUL 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" > NUL 2>&1
rd /s /q "%ProgramData%\Microsoft OneDrive" > NUL 2>&1
rd /s /q "C:\OneDriveTemp" > NUL 2>&1
REG Delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG Delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG delete "HKEY_USERS\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Run" /f > NUL 2>&1
END