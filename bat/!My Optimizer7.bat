echo ���Ҽ����Թ���Ա������С�

::ȥ����ݷ�ʽ����
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f

::ȥ�������ļ�
powercfg -h off

::win7�뿪ģʽ
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v AwayModeEnabled /t REG_DWORD /d 00000001 /f

::�Ҽ��˵������ʾ��׺�����ļ�
>"%windir%\SuperHidden.vbs" echo Dim WSHShell
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = WScript.CreateObject("WScript.Shell")
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\CLSID", "{13709620-C279-11CE-A49E-444553540000}", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\method", "ShellExecute", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo if WSHShell.RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt") = 0 then
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "2", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "��ʾ��չ�����ļ�", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}e"
>>"%windir%\SuperHidden.vbs" echo else
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "������չ�����ļ�", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}e"
>>"%windir%\SuperHidden.vbs" echo end if
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = Nothing
>>"%windir%\SuperHidden.vbs" echo WScript.Quit(0)
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "%temp%\__.reg" >nul
for /f "tokens=2 delims==" %%. in ('find/i "HideFileExt" "%temp%\__.reg"') do set v=%%~.
del "%temp%\__.reg"
set v=%v:~-1%
if %v% equ 0 set vv=������չ�����ļ�
if %v% equ 1 set vv=��ʾ��չ�����ļ�
>"%temp%\_.reg" echo REGEDIT4
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\SuperHidden]
>>"%temp%\_.reg" echo @="{00000000-0000-0000-0000-000000000012}"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\InProcServer32]
>>"%temp%\_.reg" echo @=hex(2):25,53,79,73,74,65,6d,52,6f,6f,74,25,5c,73,79,73,74,65,6d,33,32,5c,73,\
>>"%temp%\_.reg" echo   68,64,6f,63,76,77,2e,64,6c,6c,00
>>"%temp%\_.reg" echo "ThreadingModel"="Apartment"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\Instance]
>>"%temp%\_.reg" echo "CLSID"="{3f454f0e-42ae-4d7c-8ea3-328250d6e272}"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag]
>>"%temp%\_.reg" echo "method"="ShellExecute"
>>"%temp%\_.reg" echo "Param1"="SuperHidden.vbs"
>>"%temp%\_.reg" echo "CLSID"="{13709620-C279-11CE-A49E-444553540000}"
>>"%temp%\_.reg" echo "command"="%vv%"
regedit /s "%temp%\_.reg"
del /f /q "%temp%\_.reg"
echo.&echo ������Ҽ� %vv%

::�˳�����ʱ�Զ������ڴ��е�DLL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v AlwaysUnloadDll /t REG_DWORD /d 00000001 /f

::�رճ������������
sc stop PcsSvc 
sc config PcsSvc start= disabled

::�ر�UAC
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 00000000 /f

::�����Ҽ��½���Ŀ
reg delete HKEY_CLASSES_ROOT\.bmp\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.rar\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.zip\ShellNew /f
reg delete HKEY_CLASSES_ROOT\Briefcase\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.xdp\AcroExch.XDPDoc\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.jnt\jntfile\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.contact\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.rtf\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.zip\CompressedFolder\ShellNew /f

::ֹͣϵͳ��ԭ�뱸��
net stop SDRSVC

::����Ҽ��Կ��˵���
regsvr32 /u igfxpph.dll /s
regsvr32 /u atiacmxx.dll /s
regsvr32 /u nvcpl.dll /s

::ȥ����������
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAHealth" /d 1 /t REG_DWORD /f

::��������ʾ���ڼ�
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "sLongDate" /d "yyyy'��'M'��'d'��', dddd" /t REG_SZ /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "sShortDate" /d "yyyy/M/d/ddd" /t REG_SZ /f

::�ر��Զ�����
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /d 255 /t REG_DWORD /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /d 255 /t REG_DWORD /f

::�Ҽ��˵�����ü��±���
reg add "HKEY_CLASSES_ROOT\*\shell\Noteped" /ve /d ʹ�ü��±��� /f
reg add "HKEY_CLASSES_ROOT\*\shell\Noteped\command" /ve /d "notepad.exe %%1" /f

::�Ҽ��˵���ӹ���Աȡ������Ȩ
>"%temp%\_.reg" echo Windows Registry Editor Version 5.00
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\*\shell\runas]
>>"%temp%\_.reg" echo @="����Աȡ������Ȩ"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\*\shell\runas\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\exefile\shell\runas2]
>>"%temp%\_.reg" echo @="����Աȡ������Ȩ"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\exefile\shell\runas2\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\shell\runas]
>>"%temp%\_.reg" echo @="����Աȡ������Ȩ"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\shell\runas\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t"
regedit /s "%temp%\_.reg"
del /f /q "%temp%\_.reg"

::��������ɨ��ȴ�ʱ��
chkntfs /t:2

::�ӿ�˵���������Ԥ������ʾ�ٶ�
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /d 0 /t REG_SZ /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseHoverTime /d 0 /t REG_SZ /f

::����Ҽ��˵����������ѽ��
reg delete "HKEY_CLASSES_ROOT\lnkfile\shellex\ContextMenuHandlers\Compatibility" /f
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f
reg delete "HKEY_CLASSES_ROOT\batfile\ShellEx\ContextMenuHandlers\Compatibility" /f

::����Ҽ��˵���ԭ��ǰ�İ汾
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f

::�ر�DEP
bcdedit /set nx alwaysoff

::ִ�йػ�ʱǿ���˳�Ӧ�ó���
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeout /d 1000 /t REG_SZ /f

echo ��ʾ��֪�ļ���չ��
reg add HKCU\Software\Microsoft\Windows\Currentversion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
echo ȡ�����ļ�����
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v ModRiskFileTypes /t REG_SZ /d .bat;.cmd;.exe;.vbs /f
echo �ر�����С����
echo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /v "TurnOffSidebar" /t REG_DWORD /d 1 /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\Gadgets" /f
echo �ر������Ҽ��˵�-�Կ�����
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\ACE" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\NvCplDesktopContext" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\igfxDTCM" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\igfxcui" /f
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v HotKeysCmds /f
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v IgfxTray /f
echo ����Ҽ��˵���ԭ��ǰ�İ汾���ļ��С�������
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
echo �ر�Windows Defender
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
sc stop WinDefend >nul
sc config WinDefend start= disabled >nul
echo �ر�Windows����ǽ
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
sc stop MpsSvc
sc config MpsSvc start=disabled >nul
echo �ر�Windows��������
net stop wuauserv >nul
sc config wuauserv start=disabled >nul
echo �ر�Windows��ȫ����
sc stop wscsvc >nul
sc config wscsvc start= disabled >nul
echo ���ò�ֹͣӲ���Զ����ŷ���
sc config ShellHWDetection start= disabled
sc stop ShellHWDetection
echo �ر�SmartscreenӦ��ɸѡ��
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d off /t REG_SZ /f
echo ����IE��ҳ
reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /f >nul
echo ����IE��ҳ http://www.baidu.com/?tn=baidulocal
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "https://www.baidu.com/?tn=baiduhome" /f
echo ����IE��ҳ
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /d 1 /f >nul
echo �ر�Windows10������ʾ
taskkill /F /IM GWX.exe
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v DisableGwx /t REG_DWORD /d 1 /f
del /f /s /a /q %SystemRoot%\System32\GWX
gpupdate /force
echo �ٳ�һЩ�޸���ҳ�ͺ�̨�����ƹ���ļ�
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345MiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345Movie.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Downloader_2345Explorer.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HaoZipHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
taskkill /f /im explorer.exe
start %systemroot%\explorer
exit

start "title" /b /wait WUSA.exe /quiet /norestart /uninstall /kb:3035583