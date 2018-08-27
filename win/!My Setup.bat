@ECHO OFF
rem 11:50 2018/8/27
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 10 调整工具
COLOR 0a

:: 清空剪贴版
mshta vbscript:clipboardData.SetData("text","")(close)

:: 服务调整部分：Win默认禁用的服务：AppVClient NetTcpPortSharing ssh-agent RemoteRegistry RemoteAccess shpamsvc tzautoupdate UevAgentService

::cmgos（神州网信禁用部分）
::Fax
sc config Fax start= disabled
::Performance Logs & Alerts
sc config pla start= disabled
::Problem Reports and Solutions Control Panel Support
sc config wercplsupport start= disabled
::远程修改注册表
sc config RemoteRegistry start= disabled
::错误报告
sc config WerSvc start= disabled

::禁用使用情况信息的收集和传输
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
::Microsoft (R) 诊断中心标准收集器服务
sc config diagnosticshub.standardcollector.service start= disabled

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
rem Xbox Live 身份验证管理器
sc config XblAuthManager start= disabled
rem Xbox Live 网络服务
sc config XboxNetApiSvc start= disabled
rem Xbox Live 游戏保存
sc config XblGameSave start= disabled
rem 禁用 XBOX GameDVR
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f > NUL 2>&1

::Downloaded Maps Manager
sc config MapsBroker start= disabled
::Geolocation Service
sc config lfsvc start= disabled
::Program Compatibility Assistant Service
sc config PcaSvc start= disabled
::Shell Hardware Detection
sc config ShellHWDetection start= disabled
::Superfetch
sc config SysMain start= disabled
::Windows Media Player Network Sharing Service
sc config WMPNetworkSvc start= disabled
::Windows Search
taskkill /f /im searchui.exe > NUL 2>&1
sc config WSearch start= disabled
::零售演示服务
sc config RetailDemo start= disabled

echo 正在禁用微软遥测相关任务计划，请稍候……
SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Autochk\Proxy" /disable
SCHTASKS /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
SCHTASKS /Change /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" /disable
SCHTASKS /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
SCHTASKS /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /disable
SCHTASKS /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /disable
SCHTASKS /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
SCHTASKS /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable

:: 视觉：右键菜单调整-添加部分：
::添加:显示/隐藏文件(按Shift显示)
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
reg add "HKCR\Directory\Background\shell\SuperHidden" /ve /d "显示/隐藏文件"(H)"" /f
reg add "HKCR\Directory\Background\shell\SuperHidden" /v "Extended" /d "" /f
reg add "HKCR\Directory\Background\shell\SuperHidden\Command" /ve /d "WScript.exe C:\windows\SuperHidden.vbs" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 2 /f

::添加：管理员取得所有权(获取TrustedInstaller权限)（在文件上按住shift显示）
reg add "HKCR\*\shell\runas" /ve /d "管理员取得所有权" /f
reg add "HKCR\*\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\*\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\*\shell\runas" /v "Extended" /d "" /f
reg add "HKCR\*\shell\runas" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\*\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f

reg add "HKCR\Directory\shell\runas" /ve /d "管理员取得所有权" /f
reg add "HKCR\Directory\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "Extended" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\Directory\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f

reg add "HKCR\exefile\shell\runas2" /ve /d "管理员取得所有权" /f
reg add "HKCR\exefile\shell\runas2" /v "HasLUAShield" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "Extended" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\exefile\shell\runas2\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\exefile\shell\runas2\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f

::添加：文件：用记事本打开（97）
reg add "HKCR\*\shell\Noteped" /ve /d "用记事本打开" /f
reg add "HKCR\*\shell\Noteped" /v "icon" /d "imageres.dll,289" /f
reg add "HKCR\*\shell\Noteped\command" /ve /d "notepad.exe %%1" /f

::添加：文件：新建：批处理（Bat&CMD）
reg add "HKCR\.bat" /ve /d "batfile" /f
reg add "HKCR\.bat\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
reg add "HKCR\.bat\ShellNew" /v "NullFile" /d "" /f
::reg add "HKCR\.cmd" /ve /d "cmdfile" /f
::reg add "HKCR\.cmd\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
::reg add "HKCR\.cmd\ShellNew" /v "NullFile" /d "" /f

::添加：文件：注册(销)DLL/OCX文件
reg add "HKCR\dllfile\shell\注册 DLL\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\dllfile\shell\注销 DLL\Command" /ve /d "Regsvr32 /u %%1" /f
reg add "HKCR\ocxfile\shell\注册 OCX\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\ocxfile\shell\注销 OCX\Command" /ve /d "Regsvr32 /u %%1" /f
::添加：文件夹：CMD快速通道
reg add "HKCR\folder\shell\cmd" /ve /d "在此处打开命令提示符" /f
reg add "HKCR\folder\shell\cmd" /v "icon" /d "shell32.dll,71" /f
reg add "HKCR\folder\shell\cmd" /v "Extended" /d "" /f
reg add "HKCR\folder\shell\cmd\command" /ve /d "cmd.exe /s /k pushd \"%%V\"" /f

:: 视觉：右键菜单调整-清理部分：
::清理：文件：新建：
rem .BMP文件
reg delete "HKCR\.bmp\ShellNew" /f > NUL 2>&1
rem .联系人 
reg delete "HKCR\.contact\ShellNew" /f > NUL 2>&1
rem .RTF文件
reg delete "HKCR\.rtf\ShellNew" /f > NUL 2>&1
::清理：回收站右键：固定到开始屏幕
reg delete "HKLM\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
::清理：文件：“授予访问权限”（需重启）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}" /d "" /f > NUL 2>&1
::清理：文件：兼容性疑难解答
reg delete "HKCR\Msi.Package\shellex\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
::清理：文件：固定到开始屏幕
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
::清理：文件：共享
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f > NUL 2>&1
::清理：文件：还原以前的版本
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
::清理：禁用目录、文件夹、所有对象、的“始终脱机可用”
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\Offline Files" /f > NUL 2>&1
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\Offline Files" /f > NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f > NUL 2>&1
::清理：磁盘文件夹：“启用Bitlocker”右键菜单
reg delete "HKCR\Drive\shell\encrypt-bde" /f > NUL 2>&1
reg delete "HKCR\Drive\shell\encrypt-bde-elev" /f > NUL 2>&1
::清理：磁盘文件夹：“固定到快速访问”
reg delete "HKCR\Folder\shell\pintohome" /f > NUL 2>&1
::清理：磁盘文件夹：“包含到库中”
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\Library Location" /f > NUL 2>&1
::清理：文件：图片：使用画图3D进行编辑
reg delete "HKCR\SystemFileAssociations\.bmp\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.png\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\Shell\3D Edit" /f > NUL 2>&1
::清理：文件：图片：向左、向右旋转
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
::清理：文件：图像、音频、视频及其他格式右键：播放到设备
reg delete "HKCR\SystemFileAssociations\image\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\audio\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\video\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.mkv\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.mp4\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.m4v\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Audio\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Image\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Video\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
::隐藏：图片右键：编辑（在文件上按住shift显示）
reg add "HKCR\SystemFileAssociations\image\shell\edit" /v "Extended" /d "" /f
::隐藏：图片右键：设置为桌面背景（在文件上按住shift显示）
reg add "HKCR\SystemFileAssociations\.jpg\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.png\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.bmp\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.tif\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.gif\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
::隐藏：部分文件格式的右键：打印（在文件上按住shift显示）
reg add "HKCR\SystemFileAssociations\image\shell\print" /v "Extended" /d "" /f
reg add "HKCR\batfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\cmdfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\regfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\txtfile\shell\print" /v "Extended" /d "" /f
::清理：显卡项
::reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\ACE" /f > NUL 2>&1
::reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\NvCplDesktopContext" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxDTCM" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxOSP" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxcui" /f > NUL 2>&1
::清理：上传到百度网盘，上传到WPS文档
reg delete "HKCR\*\shellex\ContextMenuHandlers\qingshellext" /f > NUL 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers\YunShellExt" /f > NUL 2>&1

:: 视觉：我的电脑、文件夹、文件资源管理器调整部分：
::我的电脑取消显示7个文件夹
rem "3D对象"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f > NUL 2>&1
rem "视频"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f > NUL 2>&1
rem "图片"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f > NUL 2>&1
rem "文档"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f > NUL 2>&1
rem "下载"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f > NUL 2>&1
rem "音乐"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f > NUL 2>&1
rem "桌面"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f > NUL 2>&1
::打开文件资源管理器时打开：此电脑
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
::在标题栏中显示完整路径
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d 1 /f
::不在“快速访问”中显示最近使用的文件（删除访问记录）
del /f /s /q "%userprofile%\recent\*.*" > NUL 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f
::不在“快速访问”中显示常用文件夹
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f
::卸载 OneDrive
taskkill /f /im explorer.exe > NUL 2>&1
taskkill /f /im OneDrive.exe > NUL 2>&1
if exist %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe (
%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall
) else (
%SYSTEMROOT%\System32\OneDriveSetup.exe /uninstall
)
rd /s /q "%UserProfile%\OneDrive" > NUL 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" > NUL 2>&1
rd /s /q "%ProgramData%\Microsoft OneDrive" > NUL 2>&1
rd /s /q "C:\OneDriveTemp" > NUL 2>&1
REG Delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG Delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
start %systemroot%\explorer

:: 视觉：桌面
::在桌面显示 计算机-此电脑（我的电脑）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
::在桌面显示 个人文件夹-用户（我的文档）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
::在桌面显示 控制面板
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0
::桌面新建去除快捷方式字样
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /d "00000000" /t REG_BINARY /f
::显示已知文件类型的扩展名
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "HideFileExt" /t REG_DWORD /d 0
::删除桌面Microsoft Edge快捷方式
set "reg=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
for /f "tokens=2*" %%a in ('reg query "%reg%" /v desktop') do set "desktop=%%b"
del /f /q "%desktop%\Microsoft Edge.lnk" >nul 2>nul
::在桌面创建多功能Internet Explorer快捷方式
reg delete "HKCR\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\CLSID\{B416D21B-3B22-B6D4-BBD3-BBD452DB3D5B}" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{00000000-0000-0000-0000-100000000001}" /f > NUL 2>&1
reg delete "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{00000000-0000-0000-0000-100000000001}" /ve /d "Internet Explorer" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}" /v "InfoTip" /d "@C:\Windows\System32\ieframe.dll,-881" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}" /v "LocalizedString" /d "@C:\Windows\System32\ieframe.dll,-880" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\DefaultIcon" /ve /d "C:\Windows\System32\ieframe.dll,-190" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell" /ve /d "Open" /f
::reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\00Home" /ve /d "打开百度首页(&B)" /f
::reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\00Home\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"https://www.baidu.com/?tn=baiduhome" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\01Nohome" /ve /d "打开空白首页(&O)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\01Nohome\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"-nohome" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\02Private" /ve /d "隐私浏览模式(&P)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\02Private\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"-private" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\03NoAddOns" /ve /d "无加载项启动(&E)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\03NoAddOns\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\"-extoff" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\04History" /ve /d "删除历史记录(&S)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\04History\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"InetCpl.cpl,ClearMyTracksByProcess 255" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\05Clean" /ve /d "删除临时文件(&T)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\05Clean\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"InetCpl.cpl,ClearMyTracksByProcess 8" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\06Set" /ve /d "Internet 属性(&R)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\06Set\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\inetcpl.cpl" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\07Connection" /ve /d "局域网络设置(&X)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\07Connection\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\Inetcpl.cpl,,4" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\08Net" /ve /d "网络连接选项(&N)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\08Net\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\"C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\ncpa.cpl" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\09Hosts" /ve /d "打开 HOSTS (&H)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\09Hosts\Command" /ve /d "\"C:\Windows\notepad.exe\"%windir%\system32\drivers\etc\hosts" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /ve /d "C:\Windows\System32\ieframe.dll,-190" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolde r" /v "HideAsDeletePerUser" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "Attributes" /t REG_DWORD /d 0 /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "HideFolderVerbs" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "WantsParseDisplayName" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "HideOnDesktopPerUser" /d "" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "ParseDisplayNameNeedsURL" /d "" /f
::在桌面创建常用银行快捷方式
set lnkdir="%USERPROFILE%\Desktop\银行"
if not exist %lnkdir% md %lnkdir%
echo [InternetShortcut] >%lnkdir%\中国工商银行.url
echo URL="http://www.icbc.com.cn/icbc/" >>%lnkdir%\中国工商银行.url
echo [InternetShortcut] >%lnkdir%\中国农业银行.url
echo URL="http://www.abchina.com/cn/" >>%lnkdir%\中国农业银行.url
echo [InternetShortcut] >%lnkdir%\中国银行.url
echo URL="http://www.boc.cn/" >>%lnkdir%\中国银行.url
echo [InternetShortcut] >%lnkdir%\中国建设银行.url
echo URL="http://www.ccb.com/" >>%lnkdir%\中国建设银行.url
echo [InternetShortcut] >%lnkdir%\中国邮政储蓄银行.url
echo URL="http://www.psbc.com/" >>%lnkdir%\中国邮政储蓄银行.url
echo [InternetShortcut] >%lnkdir%\交通银行.url
echo URL="http://www.bankcomm.com/" >>%lnkdir%\交通银行.url
echo [InternetShortcut] >%lnkdir%\中信银行.url
echo URL="http://www.citicbank.com/" >>%lnkdir%\中信银行.url
echo [InternetShortcut] >%lnkdir%\招商银行.url
echo URL="http://www.cmbchina.com/" >>%lnkdir%\招商银行.url
echo [InternetShortcut] >%lnkdir%\浦发银行.url
echo URL="http://www.spdb.com.cn/" >>%lnkdir%\浦发银行.url
echo [InternetShortcut] >%lnkdir%\民生银行.url
echo URL="http://www.cmbc.com.cn/" >>%lnkdir%\民生银行.url

:: 视觉：任务栏调整部分：
::在任务栏时间显示秒
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d 1 /f
::任务栏不显示人脉
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
::任务栏Cortana调整为隐藏
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
::合并任务栏按钮:从不
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 2 /f
::锁定任务栏
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d 0 /f

:: 使用：补充：
::添加LRC歌词格式识别
reg add "HKCR\.lrc" /ve /d "lrcfile" /f
reg add "HKCR\.lrc" /v "PerceivedType" /d "text" /f
reg add "HKCR\lrcfile" /ve /d "lrc 歌词" /f
reg add "HKCR\lrcfile\DefaultIcon" /ve /d "imageres.dll,17" /f
reg add "HKCR\lrcfile\shell" /f
reg add "HKCR\lrcfile\shell\open" /f
reg add "HKCR\lrcfile\shell\open\command" /ve /d "NOTEPAD.EXE %%1" /f
::默认使用Chrome打开MHT
reg add "HKCR\.mht" /ve /d "ChromeHTML" /f
::默认使用Chrome打开PDF
reg add "HKCR\.pdf" /ve /d "ChromeHTML" /f
::在控制面板添加 编辑注册表 项
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "编辑注册表" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "InfoTip" /d "打开注册表编辑器" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "System.ControlPanel.Category" /d "5" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\DefaultIcon" /ve /d "%%SystemRoot%%\regedit.exe" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\Shell\Open\command" /ve /d "regedit" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "添加注册表编辑器" /f
::记事本显示状态栏
reg add "HKCU\Software\Microsoft\NotePad" /v "StatusBar" /t REG_DWORD /d 1 /f
::记事本自动换行
reg add "HKCU\Software\Microsoft\NotePad" /v "fwrap" /t REG_DWORD /d 1 /f

:: 使用：启动 性能
::启动和故障恢复：开机：设置开机磁盘扫描等待时间为1秒
chkntfs /t:1
::启动和故障恢复：开机：设置开机显示操作系统列表时间2秒
bcdedit /timeout 2
::清理启动项
attrib -s -h -r "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\*.*" 1>nul 2>nul
attrib -s -h -r "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\*.*" 1>nul 2>nul
del /f /q "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
::启用电源计划“高性能”
rem powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
::添加电源计划“卓越性能”（1803以后不需要再添加）
rem powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
::启用电源计划“卓越性能”
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
::启用Win离开模式
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "AwayModeEnabled" /t REG_DWORD /d 1 /f
::关闭休眠
powercfg -h off
::启动Windows免输入密码自动登陆"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon" /d "1" /f

:: 使用：安全：
::关闭用户账户控制(UAC)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /d 0 /t REG_DWORD /f
::去除UAC小盾牌
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
::禁用Windows Defender 安全中心服务
reg add "HKLM\SYSTEM\ControlSet001\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
::关闭Windows Defender Antivirus Service：帮助用户防止恶意软件及其他潜在的垃圾软件。(Windows Defender 改为手动启动)
rem Reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v WindowsDefender /f
Reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v SecurityHealth /f >nul 2>nul
::关闭Windows Defender
taskkill /f /im MSASCuil.exe >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /d 1 /t REG_DWORD /f
::在未安装通过微软注册的杀软的情况下关闭Windows Security Center ：1、点击“主页”→“病毒和威胁防护”，关闭“实时保护”；
reg add "HKLM\SOFTWARE\Microsoft\Security Center\Feature" /v "DisableAvCheck" /t REG_DWORD /d 1 /f
::关闭Smartscreen应用筛选器
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d "Off" /f
::关闭打开  本地  文件的“安全警告”
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /d ".7z;.cab;.bat;.chm;.cmd;.exe;.js;.msi;.rar;.reg;.vbs;.zip;.txt" /f
::关闭打开 局域网 文件的“安全警告”（Internet选项：加载应用程序和不安全文件时不提示）
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t REG_DWORD /d 0 /f
::关闭IE的安全设置检查功能
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /v "DisableSecuritySettingsCheck" /t REG_DWORD /d 1 /f
::关闭安全通知
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f
::关闭 Windows 10 系统信息反馈
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /d 0 /t REG_DWORD /f
::禁止一联网就打开浏览器
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /d 1 /t REG_DWORD /f
::劫持一些修改主页和后台下载推广的文件
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345MiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicMiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Downloader_2345Explorer.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HaoZipHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\KuaizipUpdate.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QQPcmgrDownload.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\install_duba.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\install_ksafe.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wzdh2345.exe" /v Debugger /t REG_SZ /d "p" /f

:: 使用：IE：
::跳过IE首次运行自定义设置
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f
::隐藏Internet Explorer右上角的笑脸反馈按钮
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v "NoHelpItemSendFeedback" /t REG_DWORD /d 1 /f
::设置IE启动浏览器时打开的主页
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Start Page" /d "about:blank" /f
::设置IE默认主页Default_Page_URL
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Default_Page_URL" /d "about:blank" /f
::设置默认搜索
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Default_Search_URL" /d "https://www.baidu.com/s?tn=baiduhome&wd=%s" /f
::设置默认搜索页面
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Search Page" /d "https://www.baidu.com/" /f
::设置IE主页
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "https://www.baidu.com/?tn=baiduhome" /f
::启用表单的自动完成功能
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use FormSuggest" /d "yes" /f
::关闭多个选项卡时不发出警告
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "WarnOnClose" /t REG_DWORD /d 0 /f
::从当前窗口的新选项卡中打开外部连接
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "ShortcutBehavior" /t REG_DWORD /d 1 /f
::锁定Internet Explorer工具栏
reg add "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /v "Locked" /t REG_DWORD /d 1 /f
::IE修改默认搜索引擎
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "DisplayName" /d "百度" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "URL" /d "https://www.baidu.com/s?tn=baiduhome&wd={searchTerms}" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "SuggestionsURL_JSON" /d "http://suggestion.baidu.com/su?wd={searchTerms}&action=opensearch&ie=utf-8" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "FaviconURLFallback" /d "http://www.baidu.com/favicon.ico" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "ShowSearchSuggestions" /t REG_DWORD /d 1 /f
::IE设置默认搜索引擎为百度
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes" /v "DefaultScope" /d "{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /f
::IE搜索引擎调序
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "SortIndex" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\jd" /v "SortIndex" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\taobao" /v "SortIndex" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\sogou" /v "SortIndex" /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\so" /v "SortIndex" /t REG_DWORD /d 5 /f
::IE删除其他搜索引擎
reg delete "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes" /f
::IE添加其他搜索引擎
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "DisplayName" /d "京东" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "URL" /d "https://search.jd.com/Search?keyword={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "FaviconURLFallback" /d "https://www.jd.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "DisplayName" /d "淘宝" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "URL" /d "https://s.taobao.com/search?q={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "FaviconURLFallback" /d "https://www.taobao.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "DisplayName" /d "微信" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "URL" /d "http://weixin.sogou.com/weixin?type=2&ie=utf8&query={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "FaviconURLFallback" /d "http://weixin.qq.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "DisplayName" /d "360" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "URL" /d "http://www.so.com/s?q={searchTerms}&ie=utf-8" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "SuggestionsURL_JSON" /d "http://sug.so.360.cn/suggest?word={searchTerms}&encodein=utf-8&encodeout=utf-8&outfmt=json" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "FaviconURL" /d "http://www.so.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "ShowSearchSuggestions" /t REG_DWORD /d 1 /f
::启用“ActiveX控件”“JAVE小程序脚本”“活动脚本”等
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
::正在添加 受信任站点（本地局域网）
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /d "10.*.*.*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range2" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range2" /v ":Range" /d "192.168.*.*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range3" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range3" /v ":Range" /d "169.254.*.*" /f
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

:: 使用：微软拼音输入法配置选项
::微软拼音默认为英语输入
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f
::关闭从云中获取候选词
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d 0 /f
::关闭从云中获取贴纸
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "EnableLiveSticker" /t REG_DWORD /d 0 /f
::关闭模糊音
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Fuzzy Input" /t REG_DWORD /d 0 /f
::关闭显示新词热词搜索的提示
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Hot And Popular Word Search" /t REG_DWORD /d 0 /f

:: 使用：时间和语言-区域和语言-国家和地区：调整为 中国
::reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "45" /f
::reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "CN" /f
::时间和语言-区域和语言-国家和地区：调整为 新加坡
reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "215" /f >nul 2>nul
reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "SG" /f >nul 2>nul
::Windows Media Player 不显示首次使用对话框
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "GroupPrivacyAcceptance" /t REG_DWORD /d 1 /f > NUL 2>&1

:: 使用：更新和安装 http://bbs.pcbeta.com/viewthread-1787498-1-7.html
::关闭驱动自动更新（禁止更新）
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
::关闭系统自动更新（手动更新）
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f
::禁止自动安装游戏与应用(关闭Microsoft消费者体验)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
::禁止自动安装推荐的应用程序(关闭内置的广告、提示、应用推荐)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
::禁止 更新后向我显示“欢迎使用Windows体验”，并在我登陆时突出显示新增内容和建议的内容
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
::禁止 在使用Windows时获取提示技巧和建议
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
::禁止 偶尔在开始菜单中显示建议
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f

:: 使用：微软商店Metro应用删除 "%ProgramFiles%\WindowsApps\" ::Xbox身份认证应用：xbox identity provider https://www.microsoft.com/zh-cn/store/p/xbox-identity-provider/9wzdncrd1hkw
::重新注册全部 PowerShell Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
PowerShell "Get-AppxPackage *Microsoft.3DBuilder* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.Advertising* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.windowscommunicationsapps* | Remove-AppxPackage"

:: 使用：APP注册设置
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "UserName" /d "累累" /f
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "Registration" /d "67693a0a733a6e6c111c4e06733c6b1f" /f
reg add "HKCU\Software\WinRAR\Profiles\0" /v "RAR5" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\WinRAR\Profiles\0" /v "Default" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\WinRAR\General\Toolbar" /v "Lock" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\WinRAR\General\Toolbar" /v "Size" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\TEAM R2R\Protein Emulator" /v "Name" /d "MAGIX Software GmbH" /f
reg add "HKCU\Software\TEAM R2R\Protein Emulator" /v "SerialNumber" /d "P3-53277-00266-22015-17826-26086-07902" /f


cls
echo 更新策略
gpupdate /force 
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
ping -n 3 127.0.0.1>nul
del "%userprofile%\AppData\Local\iconcache.db" /f /q
taskkill /f /im explorer.exe
start explorer
exit
