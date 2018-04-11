rem 18:02 2018/4/11/周三
@ECHO OFF
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 调整工具
COLOR 0a

:: 1.服务调整部分：
::禁用远程修改注册表
rem Remote Registry:使远程用户能修改此计算机上的注册表设置。如果此服务被终止，只有此计算机上的用户才能修改注册表。如果此服务被禁用，任何依赖它的服务将无法启动。
sc config RemoteRegistry start=DISABLED
::禁用错误报告
rem Windows Error Reporting Service:允许在程序停止运行或停止响应时报告错误，并允许提供现有解决方案。还允许为诊断和修复服务生成日志。如果此服务被停止，则错误报告将无法正确运行，而且可能不显示诊断服务和修复的结果。
sc config WerSvc start=DISABLED
::禁用收集性能信息
rem Performance Logs & Alerts:性能日志和警报根据预配置的计划参数从本地或远程计算机收集性能数据，然后将该数据写入日志或触发警报。如果停止此服务，将不收集性能信息。如果禁用此服务，则明确依赖它的所有服务将无法启动。
sc stop pla
sc config pla start= disabled
::禁用使用情况信息的收集和传输
rem Connected User Experiences and Telemetry:服务所启用的功能支持应用程序中用户体验和连接的用户体验。此外，如果在“反馈和诊断”下启用诊断和使用情况隐私选项设置，则此服务可以根据事件来管理诊断和使用情况信息的收集和传输(用于改进 Windows 平台的体验和质量)。
rem 关闭理由：每次系统启动会大量进行读写硬盘工作 读写率能彪到100% 。这个服务是微软用于改进 Windows 平台的体验和质量的。
sc stop DiagTrack
sc config DiagTrack start= disabled
::禁用疑难解答和系统诊断服务
rem Diagnostic Policy Service:诊断策略服务启用了 Windows 组件的问题检测、疑难解答和解决方案。如果该服务被停止，诊断将不再运行。
sc stop DPS
sc config DPS start= disabled
rem Diagnostic Service Host:诊断服务主机被诊断策略服务用来承载需要在本地服务上下文中运行的诊断。如果停止该服务，则依赖于该服务的任何诊断将不再运行。
sc stop WdiServiceHost
sc config WdiServiceHost start= disabled
rem Diagnostic System Host:诊断系统主机被诊断策略服务用来承载需要在本地系统上下文中运行的诊断。如果停止该服务，则依赖于该服务的任何诊断将不再运行。
sc stop WdiSystemHost
sc config WdiSystemHost start= disabled
rem dmwappushsvc:WAP 推消息路由服务
net stop dmwappushservice > NUL 2>&1
sc config dmwappushservice start= disabled
rem Microsoft (R) 诊断中心标准收集器服务:诊断中心标准收集器服务。运行时，此服务会收集实时 ETW 事件，并对其进行处理。
net stop diagnosticshub.standardcollector.service > NUL 2>&1
sc config diagnosticshub.standardcollector.service start= disabled
::禁用零售演示服务
rem Disables RetailDemo service:当设备处于零售演示模式时，零售演示服务将控制设备活动。
net stop RetailDemo > NUL 2>&1
sc config RetailDemo start=disabled
::Data Sharing Service：提供应用程序之间的数据代理。
sc stop DsSvc
sc config DsSvc start= disabled
::禁用Superfetch服务
rem 关闭理由：可能会有时会占用大量的系统内存   Superfetch技术就是将多余的物理内存作为缓存使用的，如果有4G以上的内存完全可以关闭。
rem 延迟启动 Superfetch 服务 sc config "SysMain" start= delayed-auto
sc config SysMain start= disabled
::禁用程序兼容性助手
rem Program Compatibility Assistant Service:此服务为程序兼容性助手(PCA)提供支持。PCA 监视由用户安装和运行的程序，并检测已知兼容性问题。如果停止此服务，PCA 将无法正常运行。
sc stop PcaSvc
sc config PcaSvc start= disabled
::禁用Windows Search
rem Windows Search：为文件、电子邮件和其他内容提供内容索引、属性缓存和搜索结果。
sc stop WSearch
sc config WSearch start= disabled
del "C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb" /s > NUL 2>&1
::禁用并停止硬件自动播放服务
rem Shell Hardware Detection:为自动播放硬件事件提供通知。
sc stop ShellHWDetection
sc config ShellHWDetection start= disabled
::关闭自动播放
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
::关闭Security Center：WSCSVC(Windows 安全中心)服务监视并报告计算机上的安全健康设置。健康设置包括防火墙(打开/关闭)、防病毒(打开/关闭/过期)、反间谍软件(打开/关闭/过期)、Windows 更新(自动/手动下载并安装更新)、用户帐户控制(打开/关闭)以及 Internet 设置(推荐/不推荐)。该服务为独立软件供应商提供 COM API 以便向安全中心服务注册并记录其产品的状态。安全和维护 UI 使用该服务在“安全和维护”控制面板中提供 systray 警报和安全健康状况的图形视图。网络访问保护(NAP)使用该服务向 NAP 网络策略服务器报告客户端的安全健康状况，以便进行网络隔离决策。该服务还提供一个公共 API，以允许外部客户以编程方式检索系统的聚合安全健康状况。
sc stop wscsvc >nul
sc config wscsvc start= disabled>nul 2>nul
::关闭Windows Defender Advanced Threat Protection Service：Windows Defender 高级威胁防护服务通过监视和报告计算机上发生的安全事件来防范高级威胁。
sc stop Sense >nul
sc config Sense start= disabled >nul
::关闭Windows Defender Antivirus Network Inspection Service：帮助防止针对网络协议中的已知和新发现的漏洞发起的入侵企图
sc stop WdNisSvc >nul
sc config WdNisSvc start= disabled >nul
::关闭Windows Defender Antivirus Service：帮助用户防止恶意软件及其他潜在的垃圾软件。
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
sc stop WinDefend >nul
sc config WinDefend start= disabled >nul
::关闭Windows Defender Firewall：Windows Defender 防火墙通过阻止未授权用户通过 Internet 或网络访问你的计算机来帮助保护计算机。
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
sc stop mpssvc
sc config mpssvc start= disabled
::关闭Windows Defender 安全中心服务
sc stop SecurityHealthService
sc config SecurityHealthService start= disabled
::Geolocation Service：此服务将监视系统的当前位置并管理地理围栏(具有关联事件的地理位置)。如果你禁用此服务，应用程序将无法使用或接收有关地理位置或地理围栏的通知。
sc stop lfsvc
sc config lfsvc start= disabled
::Downloaded Maps Manager：供应用程序访问已下载地图的 Windows 服务。此服务由访问已下载地图的应用程序按需启动。禁用此服务将阻止应用访问地图。
sc config MapsBroker start= disabled>nul 2>nul
::停止系统还原与备份
net stop SDRSVC

echo    正在禁用微软遥测相关任务计划，请稍候……
SCHTASKS /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Office\Office ClickToRun Service Monitor" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetry\AgentFallBack2016" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetry\OfficeTelemetryAgentLogOn2016" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Autochk\Proxy" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\ActivateWindowsSearch" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\ConfigureInternetTimeService" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\DispatchRecoveryTasks" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\ehDRMInit" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\InstallPlayReady" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\mcupdate" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\MediaCenterRecoveryTask" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\ObjectStoreRecoveryTask" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\OCURActivate" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\OCURDiscovery" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\PBDADiscovery" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\PBDADiscoveryW1" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\PBDADiscoveryW2" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\PvrRecoveryTask" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\PvrScheduleTask" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\RegisterSearch" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\ReindexSearchRoot" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\SqlLiteRecoveryTask" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Media Center\UpdateRecordPath" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /disable>nul 2>nul
SCHTASKS /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable>nul 2>nul
cls
echo.
echo    微软遥测相关任务计划禁用完毕！



:: 2.右键菜单调整部分：


::右键菜单：新建增强
reg add "HKCR\.bat" /ve /d "batfile" /f
reg add "HKCR\.bat\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
reg add "HKCR\.bat\ShellNew" /v "NullFile" /d "" /f
reg add "HKCR\.cmd" /ve /d "cmdfile" /f
reg add "HKCR\.cmd\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
reg add "HKCR\.cmd\ShellNew" /v "NullFile" /d "" /f
reg add "HKCR\lnkfile" /v "AlwaysShowExt" /d "" /f
reg add "HKCR\InternetShortcut" /v "AlwaysShowExt" /d "" /f
::清理右键菜单：新建项目
reg delete HKEY_CLASSES_ROOT\.bmp\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.rar\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.zip\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.xdp\AcroExch.XDPDoc\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.rtf\ShellNew /f
reg delete HKEY_CLASSES_ROOT\.zip\CompressedFolder\ShellNew /f
rem .Briefcase 公文包
reg delete HKEY_CLASSES_ROOT\Briefcase\ShellNew /f
rem .jnt 新建日记本
reg delete HKEY_CLASSES_ROOT\.jnt\jntfile\ShellNew /f
rem .contact 新建联系人 
reg delete HKEY_CLASSES_ROOT\.contact\ShellNew /f
::清理右键菜单：显卡项
regsvr32 /u igfxpph.dll /s
regsvr32 /u atiacmxx.dll /s
regsvr32 /u nvcpl.dll /s
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\ACE" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\NvCplDesktopContext" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\igfxDTCM" /f
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\igfxcui" /f
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v HotKeysCmds /f
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v IgfxTray /f
::清理右键菜单：兼容性疑难解答
reg delete "HKEY_CLASSES_ROOT\lnkfile\shellex\ContextMenuHandlers\Compatibility" /f
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility" /f
reg delete "HKEY_CLASSES_ROOT\batfile\ShellEx\ContextMenuHandlers\Compatibility" /f
::清理右键菜单：还原以前的版本
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
::清理右键菜单：包含到库中
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\Library Location" /f
::清理右键菜单：授予访问权限
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}" /d "" /f
::右键菜单添加用记事本打开
reg add "HKEY_CLASSES_ROOT\*\shell\Noteped" /ve /d 使用记事本打开 /f
reg add "HKEY_CLASSES_ROOT\*\shell\Noteped\command" /ve /d "notepad.exe %%1" /f
::右键菜单添加DLL/OCX文件右键加上(反)注册
reg add "HKCR\Dllfile\shell\注册 DLL\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\Dllfile\shell\注销 DLL\Command" /ve /d "Regsvr32 /u %%1" /f
reg add "HKCR\Ocxfile\shell\注册 OCX\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\Ocxfile\shell\注销 OCX\Command" /ve /d "Regsvr32 /u %%1" /f
::右键菜单添加cmd快速通道
reg add "HKCR\folder\shell\cmd" /ve /d "在此打开CMD" /f
reg add "HKCR\folder\shell\cmd\command" /ve /d "cmd.exe /k cd %%1" /f
::右键删除-复制名称、复制路径、复制、移动
reg delete "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\Copy To" /f
reg delete "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\Move To" /f
reg delete "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shell\CopyFilePath" /f
reg delete "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shell\CopyFileName" /f
::右键删除SkyDrive Pro
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\SPFS.ContextMenu" /f


:: 3.桌面调整部分：
::在桌面显示 计算机-计算机（我的电脑）
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
::在桌面显示 个人文件夹-用户（我的文档）
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
::在桌面显示 网络
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /t REG_DWORD /d 0
::在桌面显示 回收站
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{645FF040-5081-101B-9F08-00AA002F954E}" /t REG_DWORD /d 0
::在桌面隐藏 控制面板
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /t REG_DWORD /d 1
::去除快捷方式字样
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f
::删除回收站右键固定到开始屏幕
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f
::显示已知文件扩展名
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "HideFileExt" /t REG_DWORD /d 0
reg add HKCU\Software\Microsoft\Windows\Currentversion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
::取消打开文件警告
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /d ".bat;.reg;.vbs;.chm;.msi;.cmd;.exe;.js" /f
::关闭缩略图缓存
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
::快速访问不显示常用文件夹
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f
::当资源管理器崩溃时则自动重启资源管理器
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /d "1" /t REG_DWORD /f
::开启资源管理器自动刷新功能
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Update" /v "UpdateMode" /d "1" /t REG_DWORD /f
::为桌面和资源管理器创建不同的进程
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DesktopProcess" /d "1" /t REG_DWORD /f


:: 4.任务栏调整部分：
::任务栏显示星期几
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "sLongDate" /d "yyyy'年'M'月'd'日', dddd" /t REG_SZ /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "sShortDate" /d "yyyy/M/d/ddd" /t REG_SZ /f
::任务栏显示秒
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d 1 /f
::任务栏中的Cortana调整为隐藏
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
::始终在任务栏显示所有图标和通知
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d 0 /f
::锁定任务栏
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d 1 /f
::任务栏被占满时从:不合并
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 2 /f
::任务栏显示联系人
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
::任务栏关闭小娜
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
::任务栏将“音量调节”调整为Windows 7模式
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v "EnableMtcUvc" /t REG_DWORD /d 0 /f
::隐藏语言栏上的帮助按钮
reg add "HKCU\Software\Microsoft\CTF\LangBar\ItemState\{ED9D5450-EBE6-4255-8289-F8A31E687228}" /v "DemoteLevel" /t REG_DWORD /d 3 /f
::任务栏隐藏操作中心托盘
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAHealth" /d 1 /t REG_DWORD /f


:: 5.IE相关设置
::解锁IE主页
reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /f >nul
::设置IE主页 
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "https://www.baidu.com/?tn=baiduhome" /f
::锁定IE主页
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /d 1 /f >nul
::关闭Smartscreen应用筛选器
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d off /t REG_SZ /f
::跳过IE首次运行自定义设置
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f
::启用表单的自动完成功能
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use FormSuggest" /d "yes" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v AutoSuggest /t REG_SZ /d no /f
::关闭多个选项卡时不发出警告
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "WarnOnClose" /t REG_DWORD /d 0 /f
::锁定Internet Explorer工具栏
reg add "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /v "Locked" /t REG_DWORD /d 1 /f
::将同时可用下载数目调整到 10
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPer1_0Server" /t REG_DWORD /d 10 /f
::启用建议的网站
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Suggested Sites" /v Enabled /t REG_DWORD /d 1 /f
::关闭自动更新
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions" /v NoUpdateCheck /t REG_DWORD /d 1 /f
::关闭IE请勿追踪功能(Do Not Track)
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 0 /f
::启用搜索建议
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer" /v AllowServicePoweredQSA /t REG_DWORD /d 1 /f
::关闭定位
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v PolicyDisableGeolocation /t REG_DWORD /d 1 /f
::其他
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "Use FormSuggest" /t REG_SZ /d no /f
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v "FormSuggest Passwords" /t REG_SZ /d no /f
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\SearchScopes" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f



:: 6.微软拼音输入法配置选项
::微软拼音默认为英语输入
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f
::关闭微软拼音云计算
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d 0 /f
::关闭模糊音
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Fuzzy Input" /t REG_DWORD /d 0 /f



:: 7.关闭 Windows 8/8.1/10 应用商店自动安装各种推荐应用和游戏
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
:: 关闭推送安装服务
Reg add "HKLM\SOFTWARE\Policies\Microsoft\PushToInstall" /v "DisablePushToInstall" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f
::禁用Win10系统的应用推广功能
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
if exist "%WinDir%\SysWOW64" reg add "HKCU\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0x00000000" /f >nul
if exist "%WinDir%\SysWOW64" reg add "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f >nul
if exist "%WinDir%\SysWOW64" reg add "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\PushToInstall" /v "DisablePushToInstall" /t REG_DWORD /d "1" /f >nul
schtasks /Change /DISABLE /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" >nul
Start /wait schtasks.exe /Change /DISABLE /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" >nul

:: 8.系统APP默认设置项调整
:: 记事本显示状态栏
reg add "HKCU\Software\Microsoft\NotePad" /v "StatusBar" /t REG_DWORD /d 1 /f
:: 记事本自动换行
reg add "HKCU\Software\Microsoft\NotePad" /v "fwrap" /t REG_DWORD /d 1 /f
::去除休眠文件
powercfg -h off
::Win离开模式
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v AwayModeEnabled /t REG_DWORD /d 00000001 /f
::开机磁盘扫描等待时间
chkntfs /t:2
::关闭显示器前等待时间:从不
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
::关闭DEP %systemroot%\system32\bcdedit.exe /timeout 3
bcdedit /set nx alwaysoff
::关闭磁盘碎片整理计划
SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"
::禁止Windows发送错误报告
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /d 1 /t REG_DWORD /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /d 0 /t REG_DWORD /f
::关闭系统保护并删除还原点
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /d 0 /t REG_DWORD /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR" /d 1 /t REG_DWORD /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Installer" /v "LimitSystemRestoreCheckpointing" /d 1 /t REG_DWORD /f
::禁止运行计算机自动维护计划
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v "EnabledExecution" /d 0 /t REG_DWORD /f
::关闭客户体验改善计划
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /d 0 /t REG_DWORD /f
::键盘记住上次NumLock状态
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /d "2" /f
::关闭UAC
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 00000000 /f
::去除UAC小盾牌
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
::退出程序时自动清理内存中的DLL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v AlwaysUnloadDll /t REG_DWORD /d 00000001 /f
::执行关机时强制退出应用程序（制杀后台不等待）
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /d 0 /t REG_SZ /f
::加快菜单与任务栏预览的显示速度
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /d 0 /t REG_SZ /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseHoverTime /d 0 /t REG_SZ /f
::关闭远程协助
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowToGetHelp" /d 0 /t REG_dword /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowUnsolicited" /d 0 /t REG_dword /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fDenyTSConnections" /d 1 /t REG_dword /f
::清理启动项
attrib -s -h -r "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\*.*"
attrib -s -h -r "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*.*"
attrib -s -h -r "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*.*"
del /f /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\*.*"
del /f /q "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*.*"
del /f /q "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*.*"



:: 10.其他设置调整 My Opt
::禁止打开劫持一些修改主页和后台下载推广的文件
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345MiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicMiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Downloader_2345Explorer.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HaoZipHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QQPcmgrDownload.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\install_duba.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\install_ksafe.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wzdh2345.exe" /v Debugger /t REG_SZ /d "p" /f


cls
gpupdate /force >nul
del "%userprofile%\AppData\Local\iconcache.db" /f /q
taskkill /f /im explorer.exe
start %systemroot%\explorer
start explorer
exit




::右键菜单添加：获取TrustedInstaller权限
rem 获取TrustedInstaller权限
reg add "HKCR\*\shell\runas" /ve /d "获取TrustedInstaller权限" /f
reg add "HKCR\*\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\Directory\shell\runas" /ve /d "获取TrustedInstaller权限" /f
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\Directory\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f


