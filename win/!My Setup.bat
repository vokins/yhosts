@ECHO OFF
rem 23:38 2018/10/14
cd /d "%~dp0"
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo ��ʹ���Ҽ�����Ա������У�&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 10 ��������
COLOR 0a

:: gpedit.msc  C:\Windows\System32\GroupPolicy

:: ��ռ�����
mshta vbscript:clipboardData.SetData("text","")(close)

copy /y "Notepad2.exe" "%SystemRoot%"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /d "\"C:\Windows\Notepad2.exe\" /z" /f

:: �Ӿ����Ҽ��˵�����-��Ӳ��֣�
::���:��ʾ/�����ļ�(��Shift��ʾ)
>"%windir%\SuperHidden.vbs" echo Dim WSHShell
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = WScript.CreateObject("WScript.Shell")
>>"%windir%\SuperHidden.vbs" echo sTitle1 = "SSH=0"
>>"%windir%\SuperHidden.vbs" echo sTitle2 = "SSH=1"
>>"%windir%\SuperHidden.vbs" echo if WSHShell.RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden") = 1 then
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "2", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}"
>>"%windir%\SuperHidden.vbs" echo else
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}"
>>"%windir%\SuperHidden.vbs" echo end if
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = Nothing
>>"%windir%\SuperHidden.vbs" echo WScript.Quit(0)
reg add "HKCR\Directory\Background\shell\SuperHidden" /ve /d "��ʾ/�����ļ�"(H)"" /f
reg add "HKCR\Directory\Background\shell\SuperHidden" /v "Extended" /d "" /f
reg add "HKCR\Directory\Background\shell\SuperHidden\Command" /ve /d "WScript.exe C:\windows\SuperHidden.vbs" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 2 /f
::���:������Դ������(��Shift��ʾ)
reg add "HKLM\SOFTWARE\Classes\Directory\background\shell\RestartExplorer" /ve /d "������Դ������" /f
reg add "HKLM\SOFTWARE\Classes\Directory\background\shell\RestartExplorer" /v "Extended" /d "" /f
reg add "HKLM\SOFTWARE\Classes\Directory\background\shell\RestartExplorer\Command" /ve /d "tskill explorer" /f

::��ӣ�����Աȡ������Ȩ(��ȡTrustedInstallerȨ��)�����ļ��ϰ�סshift��ʾ��
reg add "HKCR\*\shell\runas" /ve /d "����Աȡ������Ȩ" /f
reg add "HKCR\*\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\*\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\*\shell\runas" /v "Extended" /d "" /f
reg add "HKCR\*\shell\runas" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\*\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f

reg add "HKCR\Directory\shell\runas" /ve /d "����Աȡ������Ȩ" /f
reg add "HKCR\Directory\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "Extended" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\Directory\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f

reg add "HKCR\exefile\shell\runas2" /ve /d "����Աȡ������Ȩ" /f
reg add "HKCR\exefile\shell\runas2" /v "HasLUAShield" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "Extended" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\exefile\shell\runas2\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\exefile\shell\runas2\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f

::��ӣ��ļ����ü��±��򿪣�97��
reg add "HKCR\*\shell\Noteped" /ve /d "�ü��±���" /f
reg add "HKCR\*\shell\Noteped" /v "icon" /d "imageres.dll,289" /f
reg add "HKCR\*\shell\Noteped\command" /ve /d "notepad.exe %%1" /f
::���±���ʾ״̬��
reg add "HKCU\Software\Microsoft\NotePad" /v "StatusBar" /t REG_DWORD /d 1 /f
::���±��Զ�����
reg add "HKCU\Software\Microsoft\NotePad" /v "fwrap" /t REG_DWORD /d 1 /f

::��ӣ��ļ��������ļ�·��
reg add "HKCR\*\shell\copypath" /ve /d "�����ļ�·��" /f
reg add "HKCR\*\shell\copypath" /v "icon" /d "SHELL32.dll,110" /f
reg add "HKCR\*\shell\copypath\command" /ve /d "mshta vbscript:clipboarddata.setdata"(\"text\",\"%%1\")""(close)"" /f

::��ӣ��ļ��������ļ���·��
reg add "HKCR\Directory\shell\copypath" /ve /d "�����ļ���·��" /f
reg add "HKCR\Directory\shell\copypath" /v "icon" /d "SHELL32.dll,4" /f
reg add "HKCR\Directory\shell\copypath\command" /ve /d "mshta vbscript:clipboarddata.setdata"(\"text\",\"%%1\")""(close)"" /f

::��ӣ��ļ����½���������Bat&CMD��
reg add "HKCR\.bat" /ve /d "batfile" /f
reg add "HKCR\.bat\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
reg add "HKCR\.bat\ShellNew" /v "NullFile" /d "" /f
::reg add "HKCR\.cmd" /ve /d "cmdfile" /f
::reg add "HKCR\.cmd\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
::reg add "HKCR\.cmd\ShellNew" /v "NullFile" /d "" /f

::��ӣ��ļ���ע��(��)DLL/OCX�ļ�
reg add "HKCR\dllfile\shell\ע�� DLL\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\dllfile\shell\ע�� DLL\Command" /ve /d "Regsvr32 /u %%1" /f
reg add "HKCR\ocxfile\shell\ע�� OCX\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\ocxfile\shell\ע�� OCX\Command" /ve /d "Regsvr32 /u %%1" /f
::��ӣ��ļ��У�CMD����ͨ��
reg add "HKCR\folder\shell\cmd" /ve /d "�ڴ˴���������ʾ��" /f
reg add "HKCR\folder\shell\cmd" /v "icon" /d "shell32.dll,71" /f
reg add "HKCR\folder\shell\cmd" /v "Extended" /d "" /f
reg add "HKCR\folder\shell\cmd\command" /ve /d "cmd.exe /s /k pushd \"%%V\"" /f

::�ڿ��������� �༭ע��� ��
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "�༭ע���" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "InfoTip" /d "��ע���༭��" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "System.ControlPanel.Category" /d "5" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\DefaultIcon" /ve /d "%%SystemRoot%%\regedit.exe" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\Shell\Open\command" /ve /d "regedit" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "���ע���༭��" /f

::���LRC��ʸ�ʽʶ��
reg add "HKCR\.lrc" /ve /d "lrcfile" /f
reg add "HKCR\.lrc" /v "PerceivedType" /d "text" /f
reg add "HKCR\lrcfile" /ve /d "lrc ���" /f
reg add "HKCR\lrcfile\DefaultIcon" /ve /d "imageres.dll,17" /f
reg add "HKCR\lrcfile\shell" /f
reg add "HKCR\lrcfile\shell\open" /f
reg add "HKCR\lrcfile\shell\open\command" /ve /d "NOTEPAD.EXE %%1" /f

::Ĭ��ʹ��Chrome��MHT
reg add "HKCR\.mht" /ve /d "ChromeHTML" /f
::Ĭ��ʹ��Chrome��PDF
reg add "HKCR\.pdf" /ve /d "ChromeHTML" /f

::��� Windows ��Ƭ�鿴��
reg add "HKCU\Software\Classes\.bmp" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.gif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.ico" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.jpeg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.jpg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.png" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.tif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.tiff" /ve /d "PhotoViewer.FileAssoc.Tiff" /f

:: �Ӿ����Ҽ��˵�����-�����֣�
::�����ļ����½���
rem .BMP�ļ�
reg delete "HKCR\.bmp\ShellNew" /f > NUL 2>&1
rem .��ϵ�� 
reg delete "HKCR\.contact\ShellNew" /f > NUL 2>&1
rem .RTF�ļ�
reg delete "HKCR\.rtf\ShellNew" /f > NUL 2>&1
rem .rar�ļ�
reg delete "HKLM\SOFTWARE\Classes\.rar\ShellNew" /f > NUL 2>&1
rem .zip�ļ�
reg delete "HKLM\SOFTWARE\Classes\.zip\ShellNew" /f > NUL 2>&1

::��������վ�Ҽ����̶�����ʼ��Ļ
reg delete "HKLM\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
::�����ļ������������Ȩ�ޡ�����������
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}" /d "" /f > NUL 2>&1
::�����ļ������������ѽ��
reg delete "HKCR\Msi.Package\shellex\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
::�����ļ����̶�����ʼ��Ļ
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
::�����ļ�������
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f > NUL 2>&1
::�����ļ�����ԭ��ǰ�İ汾
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
::��������Ŀ¼���ļ��С����ж��󡢵ġ�ʼ���ѻ����á�
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\Offline Files" /f > NUL 2>&1
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\Offline Files" /f > NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f > NUL 2>&1
::���������ļ��У�������Bitlocker���Ҽ��˵�
reg delete "HKCR\Drive\shell\encrypt-bde" /f > NUL 2>&1
reg delete "HKCR\Drive\shell\encrypt-bde-elev" /f > NUL 2>&1
::���������ļ��У����̶������ٷ��ʡ�
reg delete "HKCR\Folder\shell\pintohome" /f > NUL 2>&1
::���������ļ��У������������С�
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\Library Location" /f > NUL 2>&1
::����ͼƬ/�����Ҽ��˵��еġ�Windows Media Player��ѡ��
reg delete "HKCR\SystemFileAssociations\audio\shell" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Audio\shell" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Image\shell" /f > NUL 2>&1
::�����ļ���ͼƬ��ʹ�û�ͼ3D���б༭
reg delete "HKCR\SystemFileAssociations\.bmp\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.png\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\Shell\3D Edit" /f > NUL 2>&1
::�����ļ���ͼƬ������������ת
reg delete "HKCR\SystemFileAssociations\.bmp\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.dds\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.dib\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.gif\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.ico\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jfif\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpe\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpeg\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jxr\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.pdd\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.png\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.psb\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.psd\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.rle\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tiff\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.wdp\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
::�����ļ���ͼ����Ƶ����Ƶ��������ʽ�Ҽ������ŵ��豸
reg delete "HKCR\SystemFileAssociations\image\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\audio\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\video\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.mkv\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.mp4\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.m4v\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Audio\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Image\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Video\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
::���أ�ͼƬ�Ҽ����༭�����ļ��ϰ�סshift��ʾ��
reg add "HKCR\SystemFileAssociations\image\shell\edit" /v "Extended" /d "" /f
::���أ�ͼƬ�Ҽ�������Ϊ���汳�������ļ��ϰ�סshift��ʾ��
reg add "HKCR\SystemFileAssociations\.jpg\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.png\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.bmp\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.tif\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.gif\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
::���أ������ļ���ʽ���Ҽ�����ӡ�����ļ��ϰ�סshift��ʾ��
reg add "HKCR\SystemFileAssociations\image\shell\print" /v "Extended" /d "" /f
reg add "HKCR\batfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\cmdfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\regfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\txtfile\shell\print" /v "Extended" /d "" /f
::�����Կ���
::reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\ACE" /f > NUL 2>&1
::reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\NvCplDesktopContext" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxDTCM" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxOSP" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxcui" /f > NUL 2>&1
::�����ϴ����ٶ����̣��ϴ���WPS�ĵ�
reg delete "HKCR\*\shellex\ContextMenuHandlers\qingshellext" /f > NUL 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers\YunShellExt" /f > NUL 2>&1
::����opendlg
reg delete "HKCR\Unknown\shell\opendlg" /f > NUL 2>&1
reg delete "HKCR\Unknown\shell\opendlg\command" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\Folder\shell\pintostartscreen" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\Folder\shell\pintostartscreen\command" /f > NUL 2>&1

:: �Ӿ����ҵĵ��ԡ��ļ��С��ļ���Դ�������������֣�
::�ҵĵ���ȡ����ʾ7���ļ���
rem "3D����"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f > NUL 2>&1
rem "��Ƶ"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f > NUL 2>&1
rem "ͼƬ"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f > NUL 2>&1
rem "�ĵ�"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f > NUL 2>&1
rem "����"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f > NUL 2>&1
rem "����"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f > NUL 2>&1
rem "����"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f > NUL 2>&1
::���ļ���Դ������ʱ ��Ϊ���ҵĵ���
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
::�ڱ���������ʾ����·��
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d 1 /f
::���ڡ����ٷ��ʡ�����ʾ���ʹ�õ��ļ���ɾ�����ʼ�¼��
del /f /s /q "%userprofile%\recent\*.*" > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f
::���ڡ����ٷ��ʡ�����ʾ�����ļ���
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f

:: �Ӿ�������
::��������ʾ �����-�˵��ԣ��ҵĵ��ԣ�
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
::��������ʾ �����ļ���-�û����ҵ��ĵ���
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
::��������ʾ �������
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0
::������ݷ�ʽ����ʾ����ݷ�ʽ������
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /d "00000000" /t REG_BINARY /f
::��ʾ��֪�ļ����͵���չ��
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "HideFileExt" /t REG_DWORD /d 0
::ǿ����ʾָ���ļ����͵���չ��
reg add "HKCR\exefile" /v "AlwaysShowExt" /d "" /f
reg add "HKCR\regfile" /v "AlwaysShowExt" /d "" /f
reg add "HKCR\batfile" /v "AlwaysShowExt" /d "" /f
::ɾ������Microsoft Edge��ݷ�ʽ
set "reg=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
for /f "tokens=2*" %%a in ('reg query "%reg%" /v desktop') do set "desktop=%%b"
del /f /q "%desktop%\Microsoft Edge.lnk" >nul 2>nul
::�����洴���๦��Internet Explorer��ݷ�ʽ
reg delete "HKCR\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{00000000-0000-0000-0000-100000000001}" /f > NUL 2>&1
reg delete "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{00000000-0000-0000-0000-100000000001}" /ve /d "Internet Explorer" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}" /v "InfoTip" /d "@C:\Windows\System32\ieframe.dll,-881" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}" /v "LocalizedString" /d "@C:\Windows\System32\ieframe.dll,-880" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\DefaultIcon" /ve /d "C:\Windows\System32\ieframe.dll,-190" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell" /ve /d "Open" /f
::reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\00Home" /ve /d "�򿪰ٶ���ҳ(&B)" /f
::reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\00Home\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"https://www.baidu.com/?tn=baiduhome" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\01Nohome" /ve /d "�򿪿հ���ҳ(&O)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\01Nohome\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"-nohome" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\02Private" /ve /d "��˽���ģʽ(&P)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\02Private\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"-private" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\03NoAddOns" /ve /d "�޼���������(&E)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\03NoAddOns\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"-extoff" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\04History" /ve /d "ɾ����ʷ��¼(&S)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\04History\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"InetCpl.cpl,ClearMyTracksByProcess 255" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\05Clean" /ve /d "ɾ����ʱ�ļ�(&T)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\05Clean\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"InetCpl.cpl,ClearMyTracksByProcess 8" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\06Set" /ve /d "Internet ����(&R)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\06Set\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\inetcpl.cpl" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\07Connection" /ve /d "������������(&X)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\07Connection\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\Inetcpl.cpl,,4" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\08Net" /ve /d "��������ѡ��(&N)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\08Net\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\ncpa.cpl" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\09Hosts" /ve /d "�� HOSTS (&H)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\09Hosts\Command" /ve /d "\"C:\Windows\notepad.exe\"%windir%\system32\drivers\etc\hosts" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /ve /d "C:\Windows\System32\ieframe.dll,-190" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolde r" /v "HideAsDeletePerUser" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "Attributes" /t REG_DWORD /d 0 /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "HideFolderVerbs" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "WantsParseDisplayName" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "HideOnDesktopPerUser" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "ParseDisplayNameNeedsURL" /d "" /f

::�����洴���๦����������IE��ݷ�ʽ
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{00000000-0000-0000-0000-100000000002}" /ve /d "��������" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}" /v "InfoTip" /d "�������У��Ҽ�ֱ��" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}" /v "LocalizedString" /d "��������" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\DefaultIcon" /ve /d "C:\Windows\System32\ieframe.dll,88" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell" /ve /d "Open" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\00" /ve /d "�ٶ���ҳ(&H)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\00\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"https://www.baidu.com/?tn=baiduhome" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\01" /ve /d "��������(&I)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\01\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"https://www.icbc.com.cn/icbc/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\02" /ve /d "ũҵ����(&A)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\02\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.abchina.com/cn/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\03" /ve /d "�й�����(&B)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\03\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.boc.cn/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\04" /ve /d "��������(&C)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\04\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.ccb.com/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\05" /ve /d "��ͨ����(&J)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\05\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.bankcomm.com/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\06" /ve /d "�ʴ�����(&P)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\06\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.psbc.com/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\07" /ve /d "��������(&M)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\07\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.cmbc.com.cn/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\08" /ve /d "��������(&Z)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\08\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.cmbchina.com/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\09" /ve /d "��������(&H)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\09\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.citicbank.com/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\10" /ve /d "�ַ�����(&H)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\shell\10\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"http://www.spdb.com.cn/" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\ShellFolder" /ve /d "C:\Windows\System32\ieframe.dll,-190" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\ShellFolde r" /v "HideAsDeletePerUser" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\ShellFolder" /v "Attributes" /t REG_DWORD /d 0 /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\ShellFolder" /v "HideFolderVerbs" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\ShellFolder" /v "WantsParseDisplayName" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\ShellFolder" /v "HideOnDesktopPerUser" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000002}\ShellFolder" /v "ParseDisplayNameNeedsURL" /d "" /f

::�����洴���������п�ݷ�ʽ if not exist %lnkdir% md %lnkdir%
set lnkdir="%USERPROFILE%\Desktop"
echo [InternetShortcut] >%lnkdir%\����ֱ��.url
echo URL="http://www.cietv.com/live/" >>%lnkdir%\����ֱ��.url
echo [InternetShortcut] >%lnkdir%\����ֱ��.url
echo URL="http://tv.cctv.com/live/" >>%lnkdir%\����ֱ��.url
echo [InternetShortcut] >%lnkdir%\���Ӱ��.url
echo URL="https://www.mianbao99.com/" >>%lnkdir%\���Ӱ��.url

:: �Ӿ����������������֣�
::��������ʱ����ʾ��
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d 1 /f
::����������ʾ����
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
::������Cortana����Ϊ����
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
::�ϲ���������ť:�Ӳ�
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 2 /f
::����������
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d 0 /f
::�ر� ������-�Ҽ�Windows Ink������
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowWindowsInkWorkspace" /t REG_DWORD /d 0 /f

:: ����������֣�WinĬ�Ͻ��õķ���AppVClient NetTcpPortSharing ssh-agent RemoteRegistry RemoteAccess shpamsvc tzautoupdate UevAgentService
::����ʹ�������Ϣ���ռ��ʹ���
::Connected User Experiences and Telemetry
sc config DiagTrack start= disabled
::Data Sharing Service
sc config DsSvc start= disabled
::Diagnostic Execution Service
sc config diagsvc start= disabled
::Diagnostic Policy Service
sc config DPS start= disabled
::Diagnostic Service Host
sc config WdiServiceHost start= disabled
::Diagnostic System Host
sc config WdiSystemHost start= disabled
::dmwappushsvc
sc config dmwappushservice start= disabled
::Microsoft (R) ������ı�׼�ռ�������
sc config diagnosticshub.standardcollector.service start= disabled
::Performance Logs & Alerts
sc config pla start= disabled
::Problem Reports and Solutions Control Panel Support
sc config wercplsupport start= disabled
::Windows Error Reporting Service(���󱨸�)
sc config WerSvc start= disabled

::Hyper-V
sc config HvHost start= disabled
sc config vmickvpexchange start= disabled
sc config vmicguestinterface start= disabled
sc config vmicshutdown start= disabled
sc config vmicheartbeat start= disabled
sc config vmicvmsession start= disabled
sc config vmictimesync start= disabled
sc config vmicvss start= disabled
sc config vmicrdv start= disabled

::Xbox
rem Xbox Accessory Management Service
sc config XboxGipSvc start= disabled
rem Xbox Game Monitoring
rem sc config xbgm start= demand
rem Xbox Live �����֤������
sc config XblAuthManager start= disabled
rem Xbox Live �������
sc config XboxNetApiSvc start= disabled
rem Xbox Live ��Ϸ����
sc config XblGameSave start= disabled
rem ���� XBOX GameDVR
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f > NUL 2>&1

::Fax
sc config Fax start= disabled
::Distributed Link Tracking Client
sc config TrkWks start= disabled
::Downloaded Maps Manager
sc config MapsBroker start= disabled
::Geolocation Service
sc config lfsvc start= disabled
::Phone Service
sc config PhoneSvc start= disabled
::Program Compatibility Assistant Service
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /d 1 /t REG_DWORD /f
sc config PcaSvc start= disabled
::Shell Hardware Detection
sc config ShellHWDetection start= disabled
::Remote Registry(Զ���޸�ע���)
sc config RemoteRegistry start= disabled
::Superfetch
sc config SysMain start= disabled
::Windows Media Player Network Sharing Service
sc config WMPNetworkSvc start= disabled
::Windows Search
taskkill /f /im searchui.exe > NUL 2>&1
sc config WSearch start= disabled
::������ʾ����
sc config RetailDemo start= disabled


:: ����ƻ�������� %windir%\system32\taskschd.msc /s
::Microsoft �ͻ�������Ƽƻ�
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Application Experience\StartupAppTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Autochk\Proxy"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Diagnosis\Scheduled"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\DiskFootprint\Diagnostics"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Feedback\Siuf\DmClient"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Location\WindowsActionDialog"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Location\Notifications"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maintenance\WinSAT"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maps\MapsUpdateTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maps\MapsToastTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\RetailDemo\CleanupOfflineContent"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\WDI\ResolutionHost"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
::Windows Defender
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
::�������Ż�����Ƭ����
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"
::�Զ���������
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup"
::XblGameSaveTask
SCHTASKS /Change /Disable /TN "\Microsoft\XblGameSave\XblGameSaveTask"
::Adobe
SCHTASKS /Change /DISABLE /TN "\AdobeAAMUpdater-1.0-%computername%-%username%"
::Officeң�����ĺ�̨����
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\Office 15 Subscription Heartbeat"
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016"
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016"

:: ʹ�ã����ºͰ�װ
::�ر������Զ����£���ֹ���£�
::reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
::�ر�ϵͳ�Զ����£��ֶ����£�
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f
::�ر� ��δ֪�ļ���ʽʱ ��Ӧ���̵�ѡ������Ӧ��
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d 1 /f

::ϵͳ-֪ͨ�Ͳ��������º�������ʾ����ӭʹ��Windows���顱�������ҵ�½ʱͻ����ʾ�������ݺͽ��������
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
::ϵͳ-֪ͨ�Ͳ�������ʹ��Windowsʱ��ȡ��ʾ���ɺͽ���
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f

::ϵͳ-��Դ��˯��
::�ر����� powercfg -h off
::������������
::powercfg -hibernate on
::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /d 1 /t REG_DWORD /f
::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /d 1 /t REG_DWORD /f
::���õ�Դ�ƻ��������ܡ�
rem powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
::��ӵ�Դ�ƻ���׿Խ���ܡ���1803�Ժ���Ҫ����ӣ�
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
::���õ�Դ�ƻ���׿Խ���ܡ�
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
::������Ļ�Զ��ر�ʱ��Ϊ��5����
powercfg -x -monitor-timeout-ac 5

::ϵͳ-Զ�����棨�ر�Զ��Э����
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowToGetHelp" /d 0 /t REG_dword /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowUnsolicited" /d 0 /t REG_dword /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fDenyTSConnections" /d 1 /t REG_dword /f

::��ֹ�Զ���װ��Ϸ��Ӧ��(�ر�Microsoft����������)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
::��ֹ�Զ���װ�Ƽ���Ӧ�ó���(�ر����õĹ�桢��ʾ��Ӧ���Ƽ�)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
::�ر��̵�Ӧ���ƹ�
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f

::��ֹ ż���ڿ�ʼ�˵�����ʾ����
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
::��ֹ �����������ϻ�ȡ��������ʾ������
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
::��ֹ �̵��ƹ�
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingNews_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingWeather_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.NetworkSpeedTest_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.Office.Sway_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.OfficeLens_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.RemoteDesktop_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.Todos_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.Whiteboard_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.WindowsAlarms_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.WindowsCalculator_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.WindowsMaps_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "VisionObjects.MyScriptNebo_1rjv6qr7skr92" /t REG_DWORD /d 0 /f

:: ʹ�ã�΢���̵�MetroӦ�� %ProgramFiles%\WindowsApps ɾ����������Desktop App Installer��Store Purchase App��Ǯ����Ӧ���̵꣩   
::Xbox�����֤Ӧ�ã�xbox identity provider https://www.microsoft.com/zh-cn/store/p/xbox-identity-provider/9wzdncrd1hkw
::����ע��ȫ�� PowerShell Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
::3DBuilder
PowerShell "Get-AppxPackage *Microsoft.3DBuilder* | Remove-AppxPackage"
::����
PowerShell "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
::��ȡ����
PowerShell "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
::Get Started
PowerShell "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
::��Ϣ
PowerShell "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
::MSPaint
PowerShell "Get-AppxPackage *Microsoft.Microsoft.MSPaint* | Remove-AppxPackage"
::3DViewer
PowerShell "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
::Office Hub
PowerShell "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
::Microsoft Solitaire Collection
PowerShell "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
::NetworkSpeedTest
PowerShell "Get-AppxPackage *Microsoft.NetworkSpeedTest* | Remove-AppxPackage"
::Office OneNote
PowerShell "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"
::Office Sway
PowerShell "Get-AppxPackage *Microsoft.Office.Sway* | Remove-AppxPackage"
::RemoteDesktop
PowerShell "Get-AppxPackage *Microsoft.RemoteDesktop* | Remove-AppxPackage"
::Services.Store.Engagement
PowerShell "Get-AppxPackage *Microsoft.Services.Store.Engagement* | Remove-AppxPackage"
::Sticky Notes
PowerShell "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
::Todos
PowerShell "Get-AppxPackage *Microsoft.Todos* | Remove-AppxPackage"
::Whiteboard
PowerShell "Get-AppxPackage *Microsoft.Whiteboard* | Remove-AppxPackage"
::����
PowerShell "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"
::����
PowerShell "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
::Print3D
PowerShell "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage"
::SkypeApp
PowerShell "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"
::WebMediaExtensions
PowerShell "Get-AppxPackage *Microsoft.WebMediaExtensions* | Remove-AppxPackage"
::ͼƬ
PowerShell "Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage"
::���Ӻ�ʱ��
PowerShell "Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage"
::���
PowerShell "Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage"
::��������
PowerShell "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
::��ͼ
PowerShell "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"
::����¼����
PowerShell "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
::�������ʼ�
PowerShell "Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage"
::Groove����
PowerShell "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
::��Ӱ�͵���
PowerShell "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"
::YourPhone
PowerShell "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
::MixedReality
PowerShell "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
::ж����Ϸ¼�ƹ�����
PowerShell "Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
PowerShell "get-appxpackage *Microsoft.XboxGamingOverlay* | remove-appxpackage"
::ж��Xbox��Ϸ���
PowerShell "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage"
::ж���̵�
::PowerShell "get-appxpackage Microsoft.DesktopAppInstaller | remove-appxpackage"
::PowerShell "get-appxpackage Microsoft.StorePurchaseApp | remove-appxpackage"
::PowerShell "get-appxpackage Microsoft.WindowsStore | remove-appxpackage"

::PowerShell "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"

start %systemroot%\explorer

::��ֹ �����ظ��ָ�Ĭ������
rem Microsoft.3DBuilder��File Types: .stl, .3mf, .obj, .wrl, .ply, .fbx, .3ds, .dae, .dxf, .bmp, .jpg, .png, .tga
reg add "HKCU\SOFTWARE\Classes\AppXvhc4p7vz4b485xfp46hhk3fq3grkdgjg" /v "NoOpenWith" /d "" /f
rem Microsoft Edge��File Types: .htm, .html
reg add "HKCU\SOFTWARE\Classes\AppX4hxtad77fbk3jkkeerkrm0ze94wjf3s9" /v "NoOpenWith" /d "" /f
rem File Types: .pdf
reg add "HKCU\SOFTWARE\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723" /v "NoOpenWith" /d "" /f
rem File Types: .svg
reg add "HKCU\SOFTWARE\Classes\AppXde74bfzw9j31bzhcvsrxsyjnhhbq66cs" /v "NoOpenWith" /d "" /f
rem File Types: .xml
reg add "HKCU\SOFTWARE\Classes\AppXcc58vyzkbjbs4ky0mxrmxf8278rk9b3t" /v "NoOpenWith" /d "" /f
rem Microsoft Photos File Types: .3g2,.3gp, .3gp2, .3gpp, .asf, .avi, .m2t, .m2ts, .m4v, .mkv, .mov, .mp4, mp4v, .mts, .tif, .tiff, .wmv
reg add "HKCU\SOFTWARE\Classes\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt" /v "NoOpenWith" /d "" /f
rem File Types: Most Image File Types
reg add "HKCU\SOFTWARE\Classes\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc" /v "NoOpenWith" /d "" /f
rem File Types: .raw, .rwl, .rw2 and others
reg add "HKCU\SOFTWARE\Classes\AppX9rkaq77s0jzh1tyccadx9ghba15r6t3h" /v "NoOpenWith" /d "" /f
rem Zune Music��File Types: .aac, .adt, .adts ,.amr, .flac, .m3u, .m4a, .m4r, .mp3, .mpa, .wav, .wma, .wpl, .zpl
reg add "HKCU\SOFTWARE\Classes\AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs" /v "NoOpenWith" /d "" /f
rem Zune Video��File Types: .3g2,.3gp, .3gpp, .avi, .divx, .m2t, .m2ts, .m4v, .mkv, .mod, .mov, .mp4, mp4v, .mpe, .mpeg, .mpg, .mpv2, .mts, .tod, .ts, .tts, .wm, .wmv, .xvid
reg add "HKCU\SOFTWARE\Classes\AppX6eg8h5sxqq90pv53845wmnbewywdqq5h" /v "NoOpenWith" /d "" /f

::�ر���Ƶ�ļ�ͼƬԤ��
reg delete "HKCR\.ape\ShellEx" /f >nul 2>nul
reg delete "HKCR\.flac\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mp3\ShellEx" /f >nul 2>nul
::�ر���Ƶ�ļ�ͼƬԤ��
reg delete "HKCR\.3gp\ShellEx" /f >nul 2>nul
reg delete "HKCR\.avi\ShellEx" /f >nul 2>nul
reg delete "HKCR\.m4a\ShellEx" /f >nul 2>nul
reg delete "HKCR\.m4v\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mkv\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mod\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mov\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mp4\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mpeg\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mpg\ShellEx" /f >nul 2>nul
reg delete "HKCR\.rmvb\ShellEx" /f >nul 2>nul
reg delete "HKCR\.wmv\ShellEx" /f >nul 2>nul

::fix chm
regsvr32 /s hhctrl.ocx
regsvr32 /s itircl.dll
regsvr32 /s itss.dll

:: ʹ�ã����� ����
::�����͹��ϻָ������������ÿ�������ɨ��ȴ�ʱ��Ϊ1��
chkntfs /t:1
::�����͹��ϻָ������������ÿ�����ʾ����ϵͳ�б�ʱ��2��
bcdedit /timeout 2
::�������ÿ�����F8��ֱ�ӽ��밲ȫģʽ
bcdedit /set {default} bootmenupolicy legacy
::����������
attrib -s -h -r "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
attrib -s -h -r "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\*.*" 1>nul 2>nul
::������������Զ���desktop.ini
attrib +s +h "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\desktop.ini"
attrib +s +h "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\desktop.ini"
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\GV Video IO Hardware Driver.ink" 1>nul 2>nul
::del /f /q "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\*.url" 1>nul 2>nul
::���Ĭ��������
::reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f


::����Win�뿪ģʽ
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "AwayModeEnabled" /t REG_DWORD /d 1 /f
::����Windows�����������Զ���½"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" /d "1" /f

:: ʹ�ã���ȫ��
::�ر��û��˻�����(UAC)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
::ȥ��UACС����
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
::�ر�Windows Defender Antivirus Service�������û���ֹ�������������Ǳ�ڵ����������(Windows Defender ��Ϊ�ֶ�����)
Reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v SecurityHealth /f >nul 2>nul
::����Windows Defender ��ȫ���ķ���
reg add "HKLM\SYSTEM\ControlSet001\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
::��δ��װͨ��΢��ע���ɱ�������¹ر�Windows Security Center
reg add "HKLM\SOFTWARE\Microsoft\Security Center\Feature" /v "DisableAvCheck" /t REG_DWORD /d 1 /f
::�ر�Windows Defender
taskkill /f /im MSASCuil.exe >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /d 1 /t REG_DWORD /f
::�ر�SmartscreenӦ��ɸѡ��
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d "Off" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 0 /f
::�رշ���ǽ
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f
::�ر��Ҳ�֪ͨ������
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f
::�رմ�  ����  �ļ��ġ���ȫ���桱
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /d ".7z;.cab;.bat;.chm;.cmd;.exe;.js;.msi;.rar;.reg;.vbs;.zip;.txt" /f
::�رմ� ������ �ļ��ġ���ȫ���桱��Internetѡ�����Ӧ�ó���Ͳ���ȫ�ļ�ʱ����ʾ��
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t REG_DWORD /d 0 /f
::���ÿͻ�������Ƽƻ�
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
::���� �豸��������Ĵ���ǩ��
reg add "HKLM\SOFTWARE\Microsoft\Driver Signing" /v "Policy" /t REG_BINARY /d "00" /f
::�ٳ�һЩ�޸���ҳ�ͺ�̨�����ƹ���ļ�
::2345
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345MiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicMiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Downloader_2345Explorer.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HaoZipHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wzdh2345.exe" /v Debugger /t REG_SZ /d "p" /f
::360
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\360wallpaper_360safe.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\360zipInst.exe" /v Debugger /t REG_SZ /d "p" /f
::Flash
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FlashHelperService.exe" /v Debugger /t REG_SZ /d "p" /f
::iQIYI
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QyFragment.exe" /v Debugger /t REG_SZ /d "p" /f
::KingSoft
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\install_duba.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\install_ksafe.exe" /v Debugger /t REG_SZ /d "p" /f
::QQ
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QQPcmgrDownload.exe" /v Debugger /t REG_SZ /d "p" /f
::TaoBao
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Dandelion.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DandelionSetup.exe" /v Debugger /t REG_SZ /d "p" /f
::Pops
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\KuaizipUpdate.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\desktoptip.exe" /v Debugger /t REG_SZ /d "p" /f

:: ʹ�ã�ʱ�������-���������-���Һ͵�����
::����Ϊ �й�
::reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "45" /f
::reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "CN" /f
::����Ϊ �¼���
::reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "215" /f >nul 2>nul
::reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "SG" /f >nul 2>nul
::����Ϊ ����
reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "244" /f >nul 2>nul
reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "US" /f >nul 2>nul
:: ʹ�ã�΢��ƴ�����뷨����ѡ��
::΢��ƴ��Ĭ��ΪӢ������
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f
::�رմ����л�ȡ��ѡ��
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d 0 /f
::�رմ����л�ȡ��ֽ
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "EnableLiveSticker" /t REG_DWORD /d 0 /f
::�ر�ģ����
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Fuzzy Input" /t REG_DWORD /d 0 /f
::�ر���ʾ�´��ȴ���������ʾ
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Hot And Popular Word Search" /t REG_DWORD /d 0 /f

::Windows Media Player ����ʾ�״�ʹ�öԻ���
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "GroupPrivacyAcceptance" /t REG_DWORD /d 1 /f > NUL 2>&1

:: ʹ�ã�IE��
::����IE�״������Զ�������
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f
::����Internet Explorer���Ͻǵ�Ц��������ť
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v "NoHelpItemSendFeedback" /t REG_DWORD /d 1 /f
::����IE���������ʱ�򿪵���ҳ
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Start Page" /d "about:blank" /f
::����IEĬ����ҳDefault_Page_URL
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Default_Page_URL" /d "about:blank" /f
::����IE��ҳ
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "https://www.baidu.com/?tn=baiduhome" /f
::����Ĭ������
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Default_Search_URL" /d "https://www.baidu.com/s?tn=baiduhome&wd=%s" /f
::����Ĭ������ҳ��
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Search Page" /d "https://www.baidu.com/" /f
::ͣ�ðٶȸ��Ի����ù������� ��ʷ��¼������Ҫ��½��https://www.baidu.com/duty/privacysettings.html
::start iexplore.exe https://www.baidu.com/duty/safe_control.html
::���ñ����Զ���ɹ���
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use FormSuggest" /d "yes" /f
::�رն��ѡ�ʱ����������
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "WarnOnClose" /t REG_DWORD /d 0 /f
::�ӵ�ǰ���ڵ���ѡ��д��ⲿ����
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "ShortcutBehavior" /t REG_DWORD /d 1 /f
::����Internet Explorer������
reg add "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /v "Locked" /t REG_DWORD /d 1 /f
::IE�޸�Ĭ����������
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "DisplayName" /d "�ٶ�" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "URL" /d "https://www.baidu.com/s?tn=baiduhome&wd={searchTerms}" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "SuggestionsURL_JSON" /d "http://suggestion.baidu.com/su?wd={searchTerms}&action=opensearch&ie=utf-8" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "FaviconURLFallback" /d "http://www.baidu.com/favicon.ico" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "ShowSearchSuggestions" /t REG_DWORD /d 1 /f
::IE����Ĭ����������Ϊ�ٶ�
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes" /v "DefaultScope" /d "{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /f
::IE�����������
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "SortIndex" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\jd" /v "SortIndex" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\taobao" /v "SortIndex" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\sogou" /v "SortIndex" /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\so" /v "SortIndex" /t REG_DWORD /d 5 /f
::IEɾ��������������
reg delete "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes" /f
::IE���������������
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "DisplayName" /d "����" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "URL" /d "https://search.jd.com/Search?keyword={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "FaviconURLFallback" /d "https://www.jd.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "DisplayName" /d "�Ա�" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "URL" /d "https://s.taobao.com/search?q={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "FaviconURLFallback" /d "https://www.taobao.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "DisplayName" /d "΢��" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "URL" /d "http://weixin.sogou.com/weixin?type=2&ie=utf8&query={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "FaviconURLFallback" /d "http://weixin.qq.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "DisplayName" /d "360" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "URL" /d "http://www.so.com/s?q={searchTerms}&ie=utf-8" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "SuggestionsURL_JSON" /d "http://sug.so.360.cn/suggest?word={searchTerms}&encodein=utf-8&encodeout=utf-8&outfmt=json" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "FaviconURL" /d "http://www.so.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "ShowSearchSuggestions" /t REG_DWORD /d 1 /f
::���á�ActiveX�ؼ�����JAVEС����ű�������ű�����
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1001" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1004" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1200" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1201" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1208" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "120B" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1400" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1402" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1405" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1406" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1607" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1609" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1806" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2201" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2300" /t REG_DWORD /d 0 /f
::������� ������վ�㣨���ؾ�������
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /d "10.*.*.*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range2" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range2" /v ":Range" /d "192.168.*.*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range3" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range3" /v ":Range" /d "169.254.*.*" /f
::�ر�IE�İ�ȫ���ü�鹦��
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /v "DisableSecuritySettingsCheck" /t REG_DWORD /d 1 /f
::127.0.0.1 ieonline.microsoft.com
SET NEWLINE=^& echo.
attrib -r %WINDIR%\system32\drivers\etc\hosts
FIND /C /I "geo2.adobe.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 geo2.adobe.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "get3.adobe.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 get3.adobe.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "ieonline.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 ieonline.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
attrib +r %WINDIR%\system32\drivers\etc\hosts
ipconfig /flushdns
::��ֹһ�����ʹ������
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d 1 /f

::Edge
::��ֹMicrosoft Edge���״����С���ӭҳ��
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge" /v "PreventFirstRunPage" /t REG_DWORD /d 0 /f
::�ر�Adobe Flash���㼴��
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Security" /v "FlashClickToRunMode" /t REG_DWORD /d 0 /f
::�ر�Edge�����ʱ��ʾ��Ҫ�ر����б�ǩҳ�𣿡�
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "AskToCloseAllTabs" /t REG_DWORD /d 0 /f
::ʹ��Microsoft�������б�
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\BrowserEmulation" /v "MSCompatibilityMode" /t REG_DWORD /d 1 /f
::������ʾ��EDGE��ΪĬ�����������ʾ
reg add "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "DisallowDefaultBrowserPrompt" /t REG_DWORD /d 1 /f
::�������Ĳ˵�����ʾ���鿴Դ�ļ����͡����Ԫ�ء�
reg add "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\F12" /v "ShowPageContextMenuEntryPoints" /t REG_DWORD /d 1 /f
::������ҳΪ�ٶ�
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Protected - It is a violation of Windows Policy to modify. See aka.ms/browserpolicy" /v "ProtectedHomepages" /t REG_BINARY /d "01000000b537b88ba50be9f2990b6f313e97830e0d51828ea90f41e5ca0f84c7665b2ded9c940a57ee945788d18f7269aeaa7fe20536c27303ffe29e5c60eac51d09b93df2aa541d56f3f13c4e95cda43b3b13ddbaa4765e555401a41b82a05e72440f956d19002426103dd63ccc248ee40a1eb07258" /f

::�� λ�ö�λ,���,��˷�,�˻���Ϣ,����,��Ϣ����,���ߵ��շ���,���ID
regedit /e "%temp%\1.reg" "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
for /f "tokens=2 delims==" %%i in ('type "%temp%\1.reg"^|find "AutoLogonSID"') do set "SID=%%~i"
reg add "HKU\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /f /v "Value" /t REG_SZ /d "Deny"
reg add "HKU\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /f /v "Value" /t REG_SZ /d "Deny"
reg add "HKU\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /f /v "Value" /t REG_SZ /d "Deny"
reg add "HKU\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /f /v "Value" /t REG_SZ /d "Deny"
reg add "HKU\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /f /v "Value" /t REG_SZ /d "Deny"
reg add "HKU\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /f /v "Value" /t REG_SZ /d "Deny"
reg add "HKU\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /f /v "Value" /t REG_SZ /d "Deny"
reg add "HKU\%SID%\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /f /v "Enabled" /t REG_DWORD /d 0
del "%temp%\1.reg" >nul 2>nul
PowerShell Sleep 1

:: ʹ�ã�APPע������
::UltraISO ע��
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "UserName" /d "����" /f
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "Registration" /d "67693a0a733a6e6c111c4e06733c6b1f" /f
::WinRAR ȥ���Ҽ��˵�����ӵġ�ѹ��...�� E-Mail��
reg add "HKCU\SOFTWARE\WinRAR\Setup\MenuItems" /v "EmailArc" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\WinRAR\Setup\MenuItems" /v "EmailOpt" /t REG_DWORD /d 0 /f
::WinRAR Ĭ��ѹ����ʽ
reg add "HKCU\Software\WinRAR\Profiles\0" /v "RAR5" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\WinRAR\Profiles\0" /v "Default" /t REG_DWORD /d 1 /f
::WinRAR ����������
reg add "HKCU\Software\WinRAR\General\Toolbar" /v "Lock" /t REG_DWORD /d 1 /f
::VegasĬ��ʹ������
reg add "HKLM\SOFTWARE\Sony Creative Software\Error Reporting Client\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\Sony Creative Software\Sony Vegas OFX GPU Video Plug-in Pack\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\Sony Creative Software\Sony Vegas Video Plug-In Pack\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\Sony Creative Software\VEGAS Pro\15.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\Sony Creative Software\VEGAS Pro\16.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Sony Creative Software\SfTrans1\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Sony Creative Software\Sony Vegas Video Plug-In Pack\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Sony Creative Software\Video Capture\6.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
::R2R����ע����Ϣ����
reg add "HKCU\SOFTWARE\TEAM R2R\Protein Emulator" /v "Name" /d "MAGIX Software GmbH" /f
reg add "HKCU\SOFTWARE\TEAM R2R\Protein Emulator" /v "SerialNumber" /d "P-1-305-722-5810" /f


cls
echo ���²���
gpupdate /force 
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
ping -n 3 127.0.0.1>nul
del "%userprofile%\AppData\Local\iconcache.db" /f /q
taskkill /f /im explorer.exe
start explorer
exit
