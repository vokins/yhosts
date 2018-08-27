echo 请右键“以管理员身份运行”
::去除休眠文件
powercfg -h off

::win离开模式
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "AwayModeEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v AwayModeEnabled /t REG_DWORD /d 00000001 /f

::右键菜单添加显示后缀隐藏文件
>"%windir%\SuperHidden.vbs" echo Dim WSHShell
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = WScript.CreateObject("WScript.Shell")
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\CLSID", "{13709620-C279-11CE-A49E-444553540000}", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\method", "ShellExecute", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo if WSHShell.RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt") = 0 then
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "2", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "显示扩展名及文件", "REG_SZ"
::>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "Display", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}e"
>>"%windir%\SuperHidden.vbs" echo else
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "隐藏文件和扩展名", "REG_SZ"
::>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "HideSth", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}e"
>>"%windir%\SuperHidden.vbs" echo end if
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = Nothing
>>"%windir%\SuperHidden.vbs" echo WScript.Quit(0)
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "%temp%\__.reg" >nul
for /f "tokens=2 delims==" %%. in ('find/i "HideFileExt" "%temp%\__.reg"') do set v=%%~.
del "%temp%\__.reg"
set v=%v:~-1%
if %v% equ 0 set vv=隐藏文件和扩展名
if %v% equ 1 set vv=显示扩展名及文件
::if %v% equ 0 set vv=HideSth
::if %v% equ 1 set vv=Display
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
::已添加右键 %vv%

::退出程序时自动清理内存中的DLL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v AlwaysUnloadDll /t REG_DWORD /d 00000001 /f

::关闭程序兼容性助手
sc stop PcsSvc 
sc config PcsSvc start= disabled

::关闭UAC
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 00000000 /f

::清理右键新建项目
reg delete HKEY_CLASSES_ROOT\.bmp\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.rar\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.zip\ShellNew /f
reg delete HKEY_CLASSES_ROOT\Briefcase\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.xdp\AcroExch.XDPDoc\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.jnt\jntfile\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.contact\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.rtf\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.zip\CompressedFolder\ShellNew /f

::停止系统还原与备份
net stop SDRSVC

::清除右键显卡菜单项
regsvr32 /u igfxpph.dll /s
regsvr32 /u atiacmxx.dll /s
regsvr32 /u nvcpl.dll /s

::去除操作中心
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAHealth" /d 1 /t REG_DWORD /f

::任务栏显示星期几
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "sLongDate" /d "yyyy'年'M'月'd'日', dddd" /t REG_SZ /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "sShortDate" /d "yyyy/M/d/ddd" /t REG_SZ /f

::关闭自动播放
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /d 255 /t REG_DWORD /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /d 255 /t REG_DWORD /f

::右键菜单添加用记事本打开
reg add "HKEY_CLASSES_ROOT\*\shell\Noteped" /ve /d 使用记事本打开 /f
reg add "HKEY_CLASSES_ROOT\*\shell\Noteped\command" /ve /d "notepad.exe %%1" /f

::右键菜单添加管理员取得所有权
>"%temp%\_.reg" echo Windows Registry Editor Version 5.00
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\*\shell\runas]
>>"%temp%\_.reg" echo @="管理员取得所有权"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\*\shell\runas\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\exefile\shell\runas2]
>>"%temp%\_.reg" echo @="管理员取得所有权"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\exefile\shell\runas2\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\shell\runas]
>>"%temp%\_.reg" echo @="管理员取得所有权"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\shell\runas\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t"
regedit /s "%temp%\_.reg"
del /f /q "%temp%\_.reg"

::开机磁盘扫描等待时间
chkntfs /t:2

::加快菜单与任务栏预览的显示速度
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /d 0 /t REG_SZ /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseHoverTime /d 0 /t REG_SZ /f

::清除右键菜单兼容性疑难解答
reg delete "HKEY_CLASSES_ROOT\lnkfile\shellex\ContextMenuHandlers\Compatibility" /f
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f
reg delete "HKEY_CLASSES_ROOT\batfile\ShellEx\ContextMenuHandlers\Compatibility" /f

::清除右键菜单还原以前的版本
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f

::关闭DEP %systemroot%\system32\bcdedit.exe /timeout 3
bcdedit /set nx alwaysoff

::执行关机时强制退出应用程序
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeout /d 1000 /t REG_SZ /f

:: My Opt

:: 清理启动项
attrib -s -h -r "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\*.*"
attrib -s -h -r "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*.*"
attrib -s -h -r "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*.*"
del /f /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\*.*"
del /f /q "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*.*"
del /f /q "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*.*"
:: 让IE支持WAP网页
reg add "HKCU\Software\Classes\MIME\Database\Content Type\text/vnd.wap.wml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f
reg add "HKCU\Software\Classes\MIME\Database\Content Type\application/xhtml+xml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f
reg add "HKCU\Software\Classes\MIME\Database\Content Type\application/vnd.wap.xhtml+xml" /v "CLSID" /d "{25336920-03F9-11cf-8FD0-00AA00686F13}" /f
:: 让WMP支持播放SWF
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" /v "wmplayer.exe" /d "0" /f
:: 记事本显示状态栏
reg add "HKCU\Software\Microsoft\NotePad" /v "StatusBar" /t REG_DWORD /d 1 /f
:: 记事本自动换行
reg add "HKCU\Software\Microsoft\NotePad" /v "fwrap" /t REG_DWORD /d 1 /f
:: 显示已知文件扩展名
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "HideFileExt" /t REG_DWORD /d 0
reg add HKCU\Software\Microsoft\Windows\Currentversion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
:: 取消打开文件警告
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v ModRiskFileTypes /t REG_SZ /d .bat;.cmd;.exe;.vbs /f
:: 右键菜单-我的电脑
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\1.设备管理器\command" /ve /d "mmc.exe devmgmt.msc" /f
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\1.添加或删除程序\command" /ve /d "control appwiz.cpl" /f
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\1.控制面板\command" /ve /d "rundll32.exe shell32.dll,Control_RunDLL" /f
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\2.启动项\Command" /ve /d "\"C:\windows\system32\Msconfig.exe\" -4" /f
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\2.注册表\Command" /ve /d "Regedit.exe" /f
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\2.服务\Command" /ve /d "mmc.exe services.msc" /f
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\3.组策略\Command" /ve /d "mmc.exe gpedit.msc" /f
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\3.本地安全策略\Command" /ve /d "mmc.exe secpol.msc" /f
reg add "HKCR\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\3.取消关机\Command" /ve /d "shutdown.exe -a" /f
:: 右键菜单添加DLL/OCX文件右键加上(反)注册
reg add "HKCR\Dllfile\shell\注册 DLL\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\Dllfile\shell\注销 DLL\Command" /ve /d "Regsvr32 /u %%1" /f
reg add "HKCR\Ocxfile\shell\注册 OCX\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\Ocxfile\shell\注销 OCX\Command" /ve /d "Regsvr32 /u %%1" /f
:: 右键菜单添加cmd快速通道
reg add "HKCR\folder\shell\cmd" /ve /d "CMD快速通道" /f
reg add "HKCR\folder\shell\cmd\command" /ve /d "cmd.exe /k cd %%1" /f
:: 右键菜单-关闭桌面显卡部分
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\ACE" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\NvCplDesktopContext" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\igfxDTCM" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\igfxcui" /f
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v HotKeysCmds /f
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v IgfxTray /f
:: 右键菜单-清除还原以前的版本：文件夹、驱动器
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
:: 在桌面显示 计算机-我的电脑
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
:: 在桌面显示 个人文件夹-我的文档
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
:: 在桌面显示 网络
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0
:: 在桌面显示 回收站
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0
:: 在桌面隐藏 控制面板
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 1
:: 在开始菜单显示“运行”栏
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_ShowRun" /t REG_DWORD /d 1 /f
:: 关闭桌面小工具
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /v "TurnOffSidebar" /t REG_DWORD /d 1 /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\Gadgets" /f
:: 关闭Windows Defender
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
sc stop WinDefend >nul
sc config WinDefend start= disabled >nul
:: 关闭Windows升级服务
net stop wuauserv >nul
sc config wuauserv start=disabled >nul
:: 关闭Windows安全中心
sc stop wscsvc >nul
sc config wscsvc start= disabled >nul
:: 禁用并停止硬件自动播放服务
sc stop ShellHWDetection
sc config ShellHWDetection start= disabled

:: 关闭Smartscreen应用筛选器
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d off /t REG_SZ /f
:: 关闭缩略图缓存
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
:: 解锁IE主页
reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /f >nul
:: 设置IE主页 http://www.baidu.com/?tn=baidulocal
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "https://www.baidu.com/?tn=baiduhome" /f
:: 锁定IE主页
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /d 1 /f >nul
:: 关闭Windows10升级提示
taskkill /F /IM GWX.exe
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v DisableGwx /t REG_DWORD /d 1 /f
:: No-Win10
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpadate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /t REG_DWORD /d 0 /f
del /f /s /a /q %SystemRoot%\System32\GWX
:: 关闭推送安装服务
Reg add "HKLM\SOFTWARE\Policies\Microsoft\PushToInstall" /v "DisablePushToInstall" /t REG_DWORD /d "1" /f
:: 劫持一些修改主页和后台下载推广的文件
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345MiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345Movie.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Downloader_2345Explorer.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HaoZipHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
gpupdate /force
taskkill /f /im explorer.exe
start %systemroot%\explorer
exit

start "title" /b /wait WUSA.exe /quiet /norestart /uninstall /kb:3035583
Start /WAIT %~dp0Flash.exe -iv -install -au
%~dp0"Windows Loader.exe" /silent /preactivate