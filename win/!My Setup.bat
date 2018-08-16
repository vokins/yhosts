@ECHO OFF
rem 11:05 2018/8/16
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 10 选项调整工具
COLOR 0a

:: 清空剪贴版
mshta vbscript:clipboardData.SetData("text","")(close)

:: 0.服务调整部分：
::禁用使用情况信息的收集和传输
rem Connected User Experiences and Telemetry:服务所启用的功能支持应用程序中用户体验和连接的用户体验。此外，如果在“反馈和诊断”下启用诊断和使用情况隐私选项设置，则此服务可以根据事件来管理诊断和使用情况信息的收集和传输(用于改进 Windows 平台的体验和质量)。
rem 关闭理由：每次系统启动会大量进行读写硬盘工作 读写率能彪到100% 。这个服务是微软用于改进 Windows 平台的体验和质量的。
sc config DiagTrack start= disabled
::Data Sharing Service:提供应用程序之间的数据代理。
sc config DsSvc start= disabled
::禁用疑难解答和系统诊断服务
rem Diagnostic Execution Service:Executes diagnostic actions for troubleshooting support
sc config diagsvc start= disabled
rem Diagnostic Policy Service:诊断策略服务启用了 Windows 组件的问题检测、疑难解答和解决方案。如果该服务被停止，诊断将不再运行。
sc config DPS start= disabled
rem Diagnostic Service Host:诊断服务主机被诊断策略服务用来承载需要在本地服务上下文中运行的诊断。如果停止该服务，则依赖于该服务的任何诊断将不再运行。
sc config WdiServiceHost start= disabled
rem Diagnostic System Host:诊断系统主机被诊断策略服务用来承载需要在本地系统上下文中运行的诊断。如果停止该服务，则依赖于该服务的任何诊断将不再运行。
sc config WdiSystemHost start= disabled
rem Microsoft (R) 诊断中心标准收集器服务:诊断中心标准收集器服务。运行时，此服务会收集实时 ETW 事件，并对其进行处理。
sc config diagnosticshub.standardcollector.service start= disabled
::禁用收集性能信息
rem Performance Logs & Alerts:性能日志和警报根据预配置的计划参数从本地或远程计算机收集性能数据，然后将该数据写入日志或触发警报。如果停止此服务，将不收集性能信息。如果禁用此服务，则明确依赖它的所有服务将无法启动。
sc config pla start= disabled

echo 正在禁用微软遥测相关任务计划，请稍候……
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /disable
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /disable
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

::禁用 WAP 推消息路由服务
rem dmwappushsvc:WAP 推消息路由服务
sc config dmwappushservice start= disabled
::禁用地图下载访问
rem Downloaded Maps Manager:供应用程序访问已下载地图的 Windows 服务。此服务由访问已下载地图的应用程序按需启动。禁用此服务将阻止应用访问地图。
sc config MapsBroker start= disabled
:: 禁用传真服务 
rem Fax 利用计算机或网络上的可用传真资源发送和接收传真。
sc config Fax start= disabled
::禁用定位服务
rem Geolocation Service:此服务将监视系统的当前位置并管理地理围栏(具有关联事件的地理位置)。如果你禁用此服务，应用程序将无法使用或接收有关地理位置或地理围栏的通知。
sc config lfsvc start= disabled
::禁用电话服务
rem Phone Service 在设备上管理电话服务状态
sc config PhoneSvc start= disabled
::禁用程序兼容性助手
rem Program Compatibility Assistant Service:此服务为程序兼容性助手(PCA)提供支持。PCA 监视由用户安装和运行的程序，并检测已知兼容性问题。如果停止此服务，PCA 将无法正常运行。
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /d 1 /t REG_DWORD /f > NUL 2>&1
sc config PcaSvc start= disabled
::禁用远程修改注册表
rem Remote Registry:使远程用户能修改此计算机上的注册表设置。如果此服务被终止，只有此计算机上的用户才能修改注册表。如果此服务被禁用，任何依赖它的服务将无法启动。
sc config RemoteRegistry start= disabled
::禁用来宾服务
rem Shared PC Account Manager:Manages profiles and accounts on a SharedPC configured device
sc config shpamsvc start= disabled
::禁用并停止硬件自动播放服务
rem Shell Hardware Detection:为自动播放硬件事件提供通知。
sc config ShellHWDetection start= disabled
::禁用传感器收集
rem Sensor Service 一项用于管理各种传感器的功能的传感器服务。管理传感器的简单设备方向(SDO)和历史记录。加载对设备方向变化进行报告的 SDO 传感器。如果停止或禁用了此服务，则将不会加载 SDO 传感器，因此不会发生自动旋转。来自传感器的历史记录收集也将停止。
sc config SensorService start= disabled
::禁用Superfetch服务
rem Superfetch:关闭理由:可能会有时会占用大量的系统内存   Superfetch技术就是将多余的物理内存作为缓存使用的，如果有4G以上的内存完全可以关闭。rem 延迟启动 Superfetch 服务 sc config SysMain start= delayed-auto
sc config SysMain start= disabled
::禁用错误报告
rem Windows Error Reporting Service:允许在程序停止运行或停止响应时报告错误，并允许提供现有解决方案。还允许为诊断和修复服务生成日志。如果此服务被停止，则错误报告将无法正确运行，而且可能不显示诊断服务和修复的结果。
sc config WerSvc start= disabled
::禁用WMP共享
rem Windows Media Player Network Sharing Service使用通用即插即用设备与其他网络播放机和媒体设备共享 Windows Media Player 媒体库
sc config WMPNetworkSvc start= disabled
::禁用Windows Search
rem Windows Search:为文件、电子邮件和其他内容提供内容索引、属性缓存和搜索结果。
sc config WSearch start= disabled
taskkill /f /im searchui.exe > NUL 2>&1
del "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb" /s > NUL 2>&1
::禁用时间同步
rem Windows Time:维护在网络上的所有客户端和服务器的时间和日期同步。如果此服务被停止，时间和日期的同步将不可用。如果此服务被禁用，任何明确依赖它的服务都将不能启动。
sc config W32Time start= disabled
::禁用零售演示服务
rem 零售演示服务:当设备处于零售演示模式时，零售演示服务将控制设备活动。
sc config RetailDemo start= disabled

::Hyper-V
sc config AppVClient start= disabled
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
::关闭游戏录制工具
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f


::并没什么用的服务
rem AllJoyn Router Service:路由本地 AllJoyn 客户端的 AllJoyn 消息。如果停止此服务，则自身没有捆绑路由器的 AllJoyn 客户端将无法运行。
sc config AJRouter start= disabled
::禁用UevAgentService
rem User Experience Virtualization Service:为应用程序和 OS 设置漫游提供支持
sc config UevAgentService start= disabled
::禁用电子钱包
rem WalletService:电子钱包客户端使用的主机对象
sc config WalletService start= disabled
::禁用数据使用量
rem 数据使用量:网络数据使用量，流量上限，限制背景数据，按流量计费的网络。
sc config DusmSvc start= disabled
::禁用无线电管理服务
rem 无线电管理和飞行模式服务
sc config RmSvc start= disabled

::禁用系统还原与备份
::sc config SDRSVC start= disabled
::禁用企业路由服务（会导致部分校园网无法使用）
rem Routing and Remote Access:在局域网以及广域网环境中为企业提供路由服务。
::sc config RemoteAccess start= disabled

:: 1.右键菜单添加部分：
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
::添加：文件：新建：批处理（Bat&CMD）
reg add "HKCR\.bat" /ve /d "batfile" /f
reg add "HKCR\.bat\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
reg add "HKCR\.bat\ShellNew" /v "NullFile" /d "" /f
::reg add "HKCR\.cmd" /ve /d "cmdfile" /f
::reg add "HKCR\.cmd\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
::reg add "HKCR\.cmd\ShellNew" /v "NullFile" /d "" /f

::添加：文件：用记事本打开
reg add "HKCR\*\shell\Noteped" /ve /d "用记事本打开" /f
reg add "HKCR\*\shell\Noteped" /v "icon" /d "imageres.dll,97" /f
reg add "HKCR\*\shell\Noteped\command" /ve /d "notepad.exe %%1" /f
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

:: 2.右键菜单清理部分：
::清理：文件：新建：
rem .BMP文件
reg delete HKEY_CLASSES_ROOT\.bmp\ShellNew /f > NUL 2>&1
rem .联系人 
reg delete HKEY_CLASSES_ROOT\.contact\ShellNew /f > NUL 2>&1
rem .RAR文件
reg delete HKEY_CLASSES_ROOT\.rar\ShellNew /f > NUL 2>&1
rem .RTF文件
reg delete HKEY_CLASSES_ROOT\.rtf\ShellNew /f > NUL 2>&1
rem .ZIP文件
reg delete HKEY_CLASSES_ROOT\.zip\ShellNew /f > NUL 2>&1
rem .jnt 新建日记本
reg delete HKEY_CLASSES_ROOT\.jnt\jntfile\ShellNew /f > NUL 2>&1
rem .Briefcase 公文包
reg delete HKEY_CLASSES_ROOT\Briefcase\ShellNew /f > NUL 2>&1
::右键菜单：清理：显卡项
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\ACE" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\NvCplDesktopContext" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxDTCM" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxOSP" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxcui" /f > NUL 2>&1
::右键菜单：清理：文件：共享（Windows 10 1709版后出现）
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f > NUL 2>&1
::右键菜单：清理：文件：还原以前的版本
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
::右键菜单：清理：文件：兼容性疑难解答
reg delete "HKCR\Msi.Package\ShellEx\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\exefile\ShellEx\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\lnkfile\ShellEx\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
::右键菜单：清理：文件：图片：使用画图3D进行编辑
reg delete "HKCR\SystemFileAssociations\.bmp\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.png\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\Shell\3D Edit" /f > NUL 2>&1
::右键菜单：清理：文件：图片：向左、向右旋转
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
::右键菜单：清理：文件：图像、音频、视频及其他格式右键：播放到设备
reg delete "HKCR\SystemFileAssociations\image\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\audio\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\video\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.mkv\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.mp4\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.m4v\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Audio\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Image\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Video\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
::右键菜单：清理：文件：固定到开始屏幕
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
::右键菜单：清理：磁盘文件夹：“启用Bitlocker”右键菜单
reg delete "HKCR\Drive\shell\encrypt-bde" /f > NUL 2>&1
reg delete "HKCR\Drive\shell\encrypt-bde-elev" /f > NUL 2>&1
::右键菜单：清理：磁盘文件夹：“固定到快速访问”
reg delete "HKCR\Folder\shell\pintohome" /f > NUL 2>&1
::右键菜单：清理：磁盘文件夹：“包含到库中”
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\Library Location" /f > NUL 2>&1
::右键菜单：清理：磁盘文件夹：“授予访问权限”（需重启）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}" /d "" /f
::右键菜单：清理：上传到百度网盘，上传到WPS文档
reg delete "HKCR\*\shellex\ContextMenuHandlers\qingshellext" /f > NUL 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers\YunShellExt" /f > NUL 2>&1
::右键菜单：隐藏：部分文件格式的右键：打印（在文件上按住shift显示）
reg add "HKCR\SystemFileAssociations\image\shell\print" /v "Extended" /d "" /f
reg add "HKCR\batfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\cmdfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\regfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\txtfile\shell\print" /v "Extended" /d "" /f
::右键菜单：隐藏：图片右键：编辑（在文件上按住shift显示）
reg add "HKCR\SystemFileAssociations\image\shell\edit" /v "Extended" /d "" /f
::右键菜单：隐藏：图片右键：设置为桌面背景（在文件上按住shift显示）
reg add "HKCR\SystemFileAssociations\.jpg\shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.png\shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.bmp\shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.tif\shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.gif\shell\setdesktopwallpaper" /v "Extended" /d "" /f

:: 3.我的电脑、文件夹调整部分：
::在我的电脑取消显示7个文件夹
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
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
::不在“快速访问”中显示最近使用的文件（删除访问记录）
del /f /s /q "%userprofile%\recent\*.*" > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f
::不在“快速访问”中显示常用文件夹
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f
::显示已知文件类型的扩展名
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "HideFileExt" /t REG_DWORD /d 0
reg add "HKCU\SOFTWARE\Microsoft\Windows\Currentversion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
::在标题栏中显示完整路径
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d 1 /f

:: 4.任务栏相关设置：
::在任务栏时间显示秒
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d 1 /f
::任务栏不显示人脉
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
::任务栏Cortana调整为隐藏
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
::合并任务栏按钮:从不
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 2 /f
::锁定任务栏
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d 0 /f

:: 5.桌面、图标调整部分：
::在桌面显示 计算机-此电脑（我的电脑）
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
::在桌面显示 个人文件夹-用户（我的文档）
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
::在桌面显示 回收站
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0
::在桌面隐藏 网络
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 1
::在桌面显示 控制面板
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 0
::桌面新建去除快捷方式字样
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f
::删除回收站右键：固定到开始屏幕
reg delete "HKLM\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
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
::reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\0Home" /ve /d "打开百度首页(&B)" /f
::reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\0Home\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\" https://www.baidu.com/?tn=baiduhome" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\1Nohome" /ve /d "打开空白首页(&H)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\1Nohome\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\" -nohome" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\2Private" /ve /d "隐私浏览模式(&P)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\2Private\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\" -private" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\3NoAddOns" /ve /d "无加载项启动(&N)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\3NoAddOns\Command" /ve /d "\"C:\Program Files\Internet Explorer\iexplore.exe\" -extoff" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\4History" /ve /d "删除历史记录(&S)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\4History\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\" InetCpl.cpl,ClearMyTracksByProcess 255" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\5Clean" /ve /d "删除临时文件(&T)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\5Clean\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\" InetCpl.cpl,ClearMyTracksByProcess 8" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\6Set" /ve /d "Internet 属性(&R)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\6Set\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\" C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\inetcpl.cpl" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\7Connection" /ve /d "局域网络设置(&X)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\7Connection\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\" C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\Inetcpl.cpl,,4" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\8Net" /ve /d "网络连接选项(&W)" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\shell\8Net\Command" /ve /d "\"C:\Windows\System32\rundll32.exe\" C:\Windows\System32\shell32.dll,Control_RunDLL C:\Windows\System32\ncpa.cpl" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /ve /d "C:\Windows\System32\ieframe.dll,-190" /f
reg add "HKCR\CLSID\{00000000-0000-0000-0000-100000000001}\ShellFolder" /v "HideAsDeletePerUser" /d "" /f
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

:: 6.浏览器相关设置
::跳过IE首次运行自定义设置
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f
::127.0.0.1 ieonline.microsoft.com
SET NEWLINE=^& echo.
attrib -r %WINDIR%\system32\drivers\etc\hosts
FIND /C /I "ieonline.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 ieonline.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
attrib +r %WINDIR%\system32\drivers\etc\hosts
::禁止IE自动更新检查
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "NoUpdateCheck" /t REG_DWORD /d 1 /f
::隐藏Internet Explorer右上角的笑脸反馈按钮
reg add "HKCU\SOFTWARE\Policies\Microsoft\Internet Explorer\Restrictions" /v "NoHelpItemSendFeedback" /t REG_DWORD /d 1 /f
::解锁IE主页
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /f >nul 2>nul
::设置IE启动浏览器时打开的主页
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Start Page" /d "about:blank" /f
::设置IE默认主页Default_Page_URL
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Default_Page_URL" /d "about:blank" /f
::设置默认搜索
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Default_Search_URL" /d "https://www.baidu.com/s?tn=baiduhome&wd=%s" /f
::设置默认搜索页面
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Search Page" /d "https://www.baidu.com/" /f
::启用表单的自动完成功能
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Use FormSuggest" /d "yes" /f
::关闭多个选项卡时不发出警告
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\TabbedBrowsing" /v "WarnOnClose" /t REG_DWORD /d 0 /f
::从当前窗口的新选项卡中打开外部连接
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\TabbedBrowsing" /v "ShortcutBehavior" /t REG_DWORD /d 1 /f
::锁定Internet Explorer工具栏
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Toolbar" /v "Locked" /t REG_DWORD /d 1 /f
::IE修改默认搜索引擎
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "DisplayName" /d "百度" /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "URL" /d "https://www.baidu.com/s?tn=baiduhome&wd={searchTerms}" /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "SuggestionsURL_JSON" /d "http://suggestion.baidu.com/su?wd={searchTerms}&action=opensearch&ie=utf-8" /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "FaviconURLFallback" /d "http://www.baidu.com/favicon.ico" /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "ShowSearchSuggestions" /t REG_DWORD /d 1 /f
::IE设置默认搜索引擎为百度
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes" /v "DefaultScope" /d "{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /f
::IE搜索引擎调序
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "SortIndex" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "SortIndex" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "SortIndex" /t REG_DWORD /d 3 /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "SortIndex" /t REG_DWORD /d 4 /f
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "SortIndex" /t REG_DWORD /d 5 /f
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
::正在添加 受信任站点（本地局域网）
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /d "10.*.*.*" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range2" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range2" /v ":Range" /d "192.168.*.*" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range3" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range3" /v ":Range" /d "169.254.*.*" /f
::启用“ActiveX控件”“JAVE小程序脚本”“活动脚本”等
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1001" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1004" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1200" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "120B" /t REG_DWORD /d 3 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1201" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1208" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1400" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1402" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1405" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1406" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1607" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1609" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2201" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2300" /t REG_DWORD /d 0 /f

:: 7.微软拼音输入法配置选项
::微软拼音默认为英语输入
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f
::关闭从云中获取候选词
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d 0 /f
::关闭从云中获取贴纸
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "EnableLiveSticker" /t REG_DWORD /d 1 /f
::关闭模糊音
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Fuzzy Input" /t REG_DWORD /d 0 /f
::关闭显示新词热词搜索的提示
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Hot And Popular Word Search" /t REG_DWORD /d 0 /f

:: 8.开始菜单以及Windows体验
::关闭锁屏时的Windows 聚焦推广
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnable" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
::关闭“使用Windows时获取技巧和建议”
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
::关闭事件追踪
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Reliability" /v "ShutdownReasonOn" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows NT\Reliability" /v "ShutdownReasonOn" /t REG_DWORD /d 0 /f
::禁止自动安装推荐的应用程序
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
::关闭Microsoft消费者体验（禁止自动安装游戏与应用）
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f

:: 9.系统APP默认设置项调整
::时间和语言-区域和语言-国家和地区：调整为 中国
::reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "45" /f
::reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "CN" /f
::时间和语言-区域和语言-国家和地区：调整为 新加坡
reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "215" /f >nul 2>nul
reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "SG" /f >nul 2>nul
::Windows Media Player 不显示首次使用对话框
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer /v "GroupPrivacyAcceptance" /t REG_DWORD /d 1 /f > NUL 2>&1
::记事本显示状态栏
reg add "HKCU\SOFTWARE\Microsoft\NotePad" /v "StatusBar" /t REG_DWORD /d 1 /f
::记事本自动换行
reg add "HKCU\SOFTWARE\Microsoft\NotePad" /v "fwrap" /t REG_DWORD /d 1 /f
::键盘记住上次NumLock状态
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /d "2" /f
::退出程序时自动清理内存中的DLL
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v AlwaysUnloadDll /t REG_DWORD /d 00000001 /f
::自动关闭停止响应的程序
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /d "1" /f
::减少关机前的程序等待
reg add "HKEY_USERS\.DEFAULT\Control Panel\Desktop" /v "HungAppTimeout" /d "200" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Desktop" /v "WaitToKillAppTimeout" /d "1000" /f
::执行关机时强制退出应用程序（关机时强杀后台不等待）
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /d 0 /t REG_SZ /f
::关闭缩略图缓存
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
::在控制面板添加 编辑注册表 项
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "编辑注册表" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "InfoTip" /d "打开注册表编辑器" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "System.ControlPanel.Category" /d "5" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\DefaultIcon" /ve /d "%%SystemRoot%%\regedit.exe" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\Shell\Open\command" /ve /d "regedit" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "添加注册表编辑器" /f

:: 10.其他设置调整 My Opt
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

:: 11.电源管理

::启用休眠
::powercfg -h on
::将休眠文件直接压缩到内存容量的最低，即：40%
::powercfg -h size 40

::设置屏幕自动关闭时间为：5分钟
powercfg -x -monitor-timeout-ac 5
powercfg -x -monitor-timeout-dc 5
::设置屏幕关闭后禁止关闭硬盘
powercfg -x -disk-timeout-ac 0
powercfg -x -disk-timeout-dc 0
::设置15分钟后睡眠
powercfg -x -standby-timeout-ac 15
powercfg -x -standby-timeout-dc 15
::睡眠后禁止休眠
powercfg -x -hibernate-timeout-ac 0
powercfg -x -hibernate-timeout-dc 0

:: 12.系统属性：
::启动和故障恢复：开机：设置开机磁盘扫描等待时间为2秒
chkntfs /t:2
::启动和故障恢复：开机：设置开机显示操作系统列表时间3秒 %systemroot%\system32\bcdedit.exe /timeout 3
bcdedit /timeout 3
::关闭远程协助
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowToGetHelp" /d 0 /t REG_dword /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowUnsolicited" /d 0 /t REG_dword /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fDenyTSConnections" /d 1 /t REG_dword /f

:: 13.安全和维护相关设置：
::关闭UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 00000000 /f
::关闭UAC小盾牌
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
::关闭打开  本地  文件的“安全警告”
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /d ".7z;.cab;.bat;.chm;.cmd;.exe;.js;.msi;.rar;.reg;.vbs;.zip" /f
::在未安装通过微软注册的杀软的情况下关闭Windows Security Center ：1、点击“主页”→“病毒和威胁防护”，关闭“实时保护”；
reg add "HKLM\SOFTWARE\Microsoft\Security Center\Feature" /v "DisableAvCheck" /t REG_DWORD /d 1 /f
::关闭Windows Defender Antivirus Service：帮助用户防止恶意软件及其他潜在的垃圾软件。(Windows Defender 改为手动启动)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /d 1 /t REG_DWORD /f
taskkill /f /im MSASCuil.exe>nul 2>nul
::关闭Windows Defender Firewall：Windows Defender 防火墙通过阻止未授权用户通过 Internet 或网络访问你的计算机来帮助保护计算机。
rem sc config MpsSvc start=disabled >nul 会导致Store无法下载
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
::关闭自动播放
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
::关闭碎片整理和优化驱动器
SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" > NUL 2>&1
::禁止打开劫持一些修改主页和后台下载推广的文件
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
::清理启动项
attrib -s -h -r "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\*.*" 1>nul 2>nul
attrib -s -h -r "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\*.*" 1>nul 2>nul
del /f /q "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul

:: 15.APP注册设置
reg add "HKCU\SOFTWARE\EasyBoot Systems\UltraISO\5.0" /v "UserName" /d "累累" /f
reg add "HKCU\SOFTWARE\EasyBoot Systems\UltraISO\5.0" /v "Registration" /d "67693a0a733a6e6c111c4e06733c6b1f" /f

reg add "HKCU\SOFTWARE\WinRAR\Profiles\0" /v "RAR5" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\WinRAR\Profiles\0" /v "Default" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\WinRAR\General\Toolbar" /v "Lock" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\WinRAR\General\Toolbar" /v "Size" /t REG_DWORD /d 3 /f

reg add "HKCU\SOFTWARE\TEAM R2R\Protein Emulator" /v "Name" /d "MAGIX Software GmbH" /f
reg add "HKCU\SOFTWARE\TEAM R2R\Protein Emulator" /v "SerialNumber" /d "P3-53277-00266-22015-17826-26086-07902" /f

cls
echo 更新策略
gpupdate /force 
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
ping -n 3 127.0.0.1>nul
del "%userprofile%\AppData\Local\iconcache.db" /f /q
taskkill /f /im explorer.exe
start %systemroot%\explorer
rem start explorer
exit
