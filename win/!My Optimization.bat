rem ver: 21:43 2018/4/27/周五
@ECHO OFF
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 10 调整工具
COLOR 0a

:: 清空剪贴版
mshta vbscript:clipboardData.SetData("text","")(close)

:: 1.服务调整部分：
::禁用远程修改注册表
rem Remote Registry:使远程用户能修改此计算机上的注册表设置。如果此服务被终止，只有此计算机上的用户才能修改注册表。如果此服务被禁用，任何依赖它的服务将无法启动。
sc config RemoteRegistry start= disabled
::禁用错误报告
rem Windows Error Reporting Service:允许在程序停止运行或停止响应时报告错误，并允许提供现有解决方案。还允许为诊断和修复服务生成日志。如果此服务被停止，则错误报告将无法正确运行，而且可能不显示诊断服务和修复的结果。
sc config WerSvc start= disabled
::禁用收集性能信息
rem Performance Logs & Alerts:性能日志和警报根据预配置的计划参数从本地或远程计算机收集性能数据，然后将该数据写入日志或触发警报。如果停止此服务，将不收集性能信息。如果禁用此服务，则明确依赖它的所有服务将无法启动。
sc stop pla > NUL
sc config pla start= disabled
::禁用使用情况信息的收集和传输
rem Connected User Experiences and Telemetry:服务所启用的功能支持应用程序中用户体验和连接的用户体验。此外，如果在“反馈和诊断”下启用诊断和使用情况隐私选项设置，则此服务可以根据事件来管理诊断和使用情况信息的收集和传输(用于改进 Windows 平台的体验和质量)。
rem 关闭理由：每次系统启动会大量进行读写硬盘工作 读写率能彪到100% 。这个服务是微软用于改进 Windows 平台的体验和质量的。
sc stop DiagTrack > NUL
sc config DiagTrack start= disabled
::禁用疑难解答和系统诊断服务
rem Diagnostic Policy Service:诊断策略服务启用了 Windows 组件的问题检测、疑难解答和解决方案。如果该服务被停止，诊断将不再运行。
sc stop DPS > NUL
sc config DPS start= disabled
rem Diagnostic Service Host:诊断服务主机被诊断策略服务用来承载需要在本地服务上下文中运行的诊断。如果停止该服务，则依赖于该服务的任何诊断将不再运行。
sc stop WdiServiceHost > NUL
sc config WdiServiceHost start= disabled
rem Diagnostic System Host:诊断系统主机被诊断策略服务用来承载需要在本地系统上下文中运行的诊断。如果停止该服务，则依赖于该服务的任何诊断将不再运行。
sc stop WdiSystemHost > NUL
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
sc config RetailDemo start= disabled
::Data Sharing Service：提供应用程序之间的数据代理。
sc stop DsSvc > NUL
sc config DsSvc start= disabled
::禁用Superfetch服务
rem 关闭理由：可能会有时会占用大量的系统内存   Superfetch技术就是将多余的物理内存作为缓存使用的，如果有4G以上的内存完全可以关闭。rem 延迟启动 Superfetch 服务 sc config SysMain start= delayed-auto
sc config SysMain start= disabled
::禁用程序兼容性助手
rem Program Compatibility Assistant Service:此服务为程序兼容性助手(PCA)提供支持。PCA 监视由用户安装和运行的程序，并检测已知兼容性问题。如果停止此服务，PCA 将无法正常运行。
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /d 1 /t REG_DWORD /f
sc stop PcaSvc > NUL
sc config PcaSvc start= disabled
::禁用Windows Search
rem Windows Search：为文件、电子邮件和其他内容提供内容索引、属性缓存和搜索结果。
sc stop WSearch > NUL
sc config WSearch start= disabled
del "C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb" /s > NUL 2>&1
::禁用Windows Media Player Network Sharing Service
rem 使用通用即插即用设备与其他网络播放机和媒体设备共享 Windows Media Player 媒体库
sc stop WMPNetworkSvc > NUL
sc config WMPNetworkSvc start= disabled
::禁用并停止硬件自动播放服务
rem Shell Hardware Detection:为自动播放硬件事件提供通知。
sc stop ShellHWDetection > NUL
sc config ShellHWDetection start= disabled
::关闭Security Center：WSCSVC(Windows 安全中心)服务监视并报告计算机上的安全健康设置。健康设置包括防火墙(打开/关闭)、防病毒(打开/关闭/过期)、反间谍软件(打开/关闭/过期)、Windows 更新(自动/手动下载并安装更新)、用户帐户控制(打开/关闭)以及 Internet 设置(推荐/不推荐)。该服务为独立软件供应商提供 COM API 以便向安全中心服务注册并记录其产品的状态。安全和维护 UI 使用该服务在“安全和维护”控制面板中提供 systray 警报和安全健康状况的图形视图。网络访问保护(NAP)使用该服务向 NAP 网络策略服务器报告客户端的安全健康状况，以便进行网络隔离决策。该服务还提供一个公共 API，以允许外部客户以编程方式检索系统的聚合安全健康状况。
sc stop wscsvc > NUL
sc config wscsvc start= disabled
::Geolocation Service：此服务将监视系统的当前位置并管理地理围栏(具有关联事件的地理位置)。如果你禁用此服务，应用程序将无法使用或接收有关地理位置或地理围栏的通知。
sc stop lfsvc > NUL
sc config lfsvc start= disabled
::Downloaded Maps Manager：供应用程序访问已下载地图的 Windows 服务。此服务由访问已下载地图的应用程序按需启动。禁用此服务将阻止应用访问地图。
sc config MapsBroker start= disabled
::停止系统还原与备份
net stop SDRSVC > NUL 2>&1
::关闭Windows Defender Antivirus Network Inspection Service：帮助防止针对网络协议中的已知和新发现的漏洞发起的入侵企图
net stop WdNisSvc > NUL
::关闭Windows Defender Antivirus Service：帮助用户防止恶意软件及其他潜在的垃圾软件。
net stop WinDefend > NUL
::关闭Windows Defender Advanced Threat Protection Service：Windows Defender 高级威胁防护服务通过监视和报告计算机上发生的安全事件来防范高级威胁。
sc stop Sense
net stop Sense

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
::右键菜单添加:显示/隐藏文件
>"%windir%\SuperHidden.vbs" echo Dim WSHShell
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = WScript.CreateObject("WScript.Shell")
>>"%windir%\SuperHidden.vbs" echo sTitle1 = "SSH=0"
>>"%windir%\SuperHidden.vbs" echo sTitle2 = "SSH=1"
>>"%windir%\SuperHidden.vbs" echo if WSHShell.RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden") = 1 then
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "2", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}"
>>"%windir%\SuperHidden.vbs" echo else
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}"
>>"%windir%\SuperHidden.vbs" echo end if
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = Nothing
>>"%windir%\SuperHidden.vbs" echo WScript.Quit(0)
reg add "HKCR\Directory\Background\shell\SuperHidden" /ve /d "显示/隐藏文件"(H)"" /f
reg add "HKCR\Directory\Background\shell\SuperHidden\Command" /ve /d "WScript.exe C:\windows\SuperHidden.vbs" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 2 /f
::右键菜单添加：获取超级管理员权限(获取TrustedInstaller权限)
reg add "HKCR\*\shell\runas" /ve /d "获取超级管理员权限" /f
reg add "HKCR\*\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\*\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\*\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\Directory\shell\runas" /ve /d "获取超级管理员权限" /f
reg add "HKCR\Directory\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\Directory\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
reg add "HKCR\exefile\shell\runas2" /ve /d "获取超级管理员权限" /f
reg add "HKCR\exefile\shell\runas2" /v "HasLUAShield" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\exefile\shell\runas2\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\exefile\shell\runas2\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
::右键菜单：新建增强
reg add "HKCR\.bat" /ve /d "batfile" /f
reg add "HKCR\.bat\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
reg add "HKCR\.bat\ShellNew" /v "NullFile" /d "" /f
reg add "HKCR\.cmd" /ve /d "cmdfile" /f
reg add "HKCR\.cmd\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
reg add "HKCR\.cmd\ShellNew" /v "NullFile" /d "" /f
reg add "HKCR\lnkfile" /v "AlwaysShowExt" /d "" /f
reg add "HKCR\InternetShortcut" /v "AlwaysShowExt" /d "" /f
::右键菜单添加：用记事本打开
reg add "HKEY_CLASSES_ROOT\*\shell\Noteped" /ve /d 用记事本打开 /f
reg add "HKEY_CLASSES_ROOT\*\shell\Noteped\command" /ve /d "notepad.exe %%1" /f
::右键菜单添加：DLL/OCX文件右键加上(反)注册
reg add "HKCR\Dllfile\shell\注册 DLL\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\Dllfile\shell\注销 DLL\Command" /ve /d "Regsvr32 /u %%1" /f
reg add "HKCR\Ocxfile\shell\注册 OCX\Command" /ve /d "Regsvr32 %%1" /f
reg add "HKCR\Ocxfile\shell\注销 OCX\Command" /ve /d "Regsvr32 /u %%1" /f
::右键菜单添加：cmd快速通道
reg add "HKCR\folder\shell\cmd" /ve /d "打开命令提示符" /f
reg add "HKCR\folder\shell\cmd\command" /ve /d "cmd.exe /k cd %%1" /f

::清理右键菜单：新建项目
rem .BMP文件
reg delete HKEY_CLASSES_ROOT\.bmp\ShellNew /f > NUL 2>&1
rem .Briefcase 公文包
reg delete HKEY_CLASSES_ROOT\Briefcase\ShellNew /f > NUL 2>&1
rem .Contact 新建联系人 
reg delete HKEY_CLASSES_ROOT\.contact\ShellNew /f > NUL 2>&1
rem .jnt 新建日记本
reg delete HKEY_CLASSES_ROOT\.jnt\jntfile\ShellNew /f > NUL 2>&1
rem .rtf文件
reg delete HKEY_CLASSES_ROOT\.rtf\ShellNew /f > NUL 2>&1
rem .ZIP/RAR文件
reg delete HKEY_CLASSES_ROOT\.rar\ShellNew /f > NUL 2>&1
reg delete HKEY_CLASSES_ROOT\.zip\ShellNew /f > NUL 2>&1
reg delete HKEY_CLASSES_ROOT\.zip\CompressedFolder\ShellNew /f > NUL 2>&1
::清理右键菜单：显卡项
regsvr32 /u igfxpph.dll /s
regsvr32 /u atiacmxx.dll /s
regsvr32 /u nvcpl.dll /s
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v HotKeysCmds /f > NUL 2>&1
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v IgfxTray /f > NUL 2>&1
::清理右键菜单：桌面的显卡菜单
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\ACE" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\NvCplDesktopContext" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxDTCM" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxOSP" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxcui" /f > NUL 2>&1
::清理右键菜单：兼容性疑难解答
reg delete "HKCR\Msi.Package\ShellEx\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\batfile\ShellEx\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\cmdfile\ShellEx\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\exefile\ShellEx\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\lnkfile\ShellEx\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
::清理右键菜单：磁盘的“启用Bitlocker”右键菜单
reg delete "HKCR\Drive\shell\encrypt-bde" /f > NUL 2>&1
reg delete "HKCR\Drive\shell\encrypt-bde-elev" /f > NUL 2>&1
::清理右键菜单：磁盘的“以便携式方式打开”右键菜单
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{D6791A63-E7E2-4fee-BF52-5DED8E86E9B8}" /f > NUL 2>&1
::清理右键菜单：磁盘的“复制磁盘”右键菜单
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{59099400-57FF-11CE-BD94-0020AF85B590}" /f > NUL 2>&1
::清理右键菜单：还原以前的版本
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
::清理右键菜单：禁用磁盘的“刻录到光盘”
reg delete "HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\{fbeb8a05-beee-4442-804e-409d6c4515e9}" /f > NUL 2>&1
::清理右键菜单：禁用目录、文件夹、所有对象、的“始终脱机可用”
reg delete "HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\Offline Files" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Offline Files" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}" /f > NUL 2>&1
::清理右键菜单：“固定到快速访问”
reg delete "HKCR\Folder\shell\pintohome" /f > NUL 2>&1
::清理右键菜单：文件夹的“包含到库中”
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\Library Location" /f > NUL 2>&1
::清理右键菜单：文件、目录、桌面、所有对象的“工作文件夹”
reg delete "HKCR\*\shellex\ContextMenuHandlers\WorkFolders" /f > NUL 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\WorkFolders" /f > NUL 2>&1
reg delete "HKCR\Directory\background\shellex\ContextMenuHandlers\WorkFolders" /f > NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shell\LaunchWorkfoldersControl" /f > NUL 2>&1
::清理右键菜单：授予访问权限
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}" /d "" /f
::清理右键菜单：删除-复制名称、复制路径、复制、移动
reg delete "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\Copy To" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\Move To" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shell\CopyFilePath" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\AllFilesystemObjects\shell\CopyFileName" /f > NUL 2>&1
::清理右键菜单：删除SkyDrive Pro
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\SPFS.ContextMenu" /f > NUL 2>&1



:: 3.我的电脑、文件夹调整部分：
::在我的电脑取消显示7个文件夹
rem "3D对象"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f > NUL 2>&1
rem "视频"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f > NUL 2>&1
rem "音乐"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f > NUL 2>&1
rem "文档"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f > NUL 2>&1
rem "桌面"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f > NUL 2>&1
rem "下载"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f > NUL 2>&1
rem "图片"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f > NUL 2>&1
::快速访问不显示常用文件夹
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f
::快速访问不显示最近使用的文件
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f
::为桌面和资源管理器创建不同的进程
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DesktopProcess" /d "1" /t REG_DWORD /f
::显示已知文件扩展名
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "HideFileExt" /t REG_DWORD /d 0
reg add HKCU\Software\Microsoft\Windows\Currentversion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
::打开资源管理器时显示此电脑
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
::关闭缩略图缓存
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
::在单独的进程中打开文件夹窗口
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f
::资源管理器窗口最小化时显示完整路径
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d 1 /f
::当资源管理器崩溃时则自动重启资源管理器
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /d "1" /t REG_DWORD /f
::开启资源管理器自动刷新功能
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Update" /v "UpdateMode" /d "1" /t REG_DWORD /f

              


:: 4.安全和维护相关设置：
::关闭客户体验改善计划
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /d 0 /t REG_DWORD /f
::关闭碎片整理和优化驱动器
SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" > NUL 2>&1
::关闭自动播放
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
::关闭Windows Defender Firewall：Windows Defender 防火墙通过阻止未授权用户通过 Internet 或网络访问你的计算机来帮助保护计算机。
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
::关闭UAC
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 00000000 /f
::去除UAC小盾牌
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
::关闭Windows Defender Antivirus Service：帮助用户防止恶意软件及其他潜在的垃圾软件。
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
::取消打开文件警告
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /d ".7z;.bat;.chm;.cmd;.exe;.js;.msi;.rar;.reg;.vbs;.zip" /f
gpupdate /force  
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters


:: 5.任务栏相关设置：
::任务栏显示星期几
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "sLongDate" /d "yyyy'年'M'月'd'日', dddd" /t REG_SZ /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "sShortDate" /d "yyyy/M/d/ddd" /t REG_SZ /f
::任务栏显示秒
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d 1 /f
::任务栏始终显示所有图标和通知
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d 0 /f
::任务栏隐藏操作中心托盘
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAHealth" /d 1 /t REG_DWORD /f
::任务栏隐藏联系人(人脉)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
::任务栏锁定
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d 1 /f
::任务栏中的Cortana调整为隐藏
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
::任务栏被占满时从:不合并
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 2 /f



:: 6.桌面、图标调整部分：
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
::桌面新建去除快捷方式字样
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f
::删除回收站右键固定到开始屏幕
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
::在桌面创建IE快捷方式(空白页)
(echo Set WshShell=CreateObject("WScript.Shell"^)
echo strDesKtop=WshShell.SpecialFolders("DesKtop"^)
echo Set oShellLink=WshShell.CreateShortcut(strDesKtop^&"\Internet Explorer.lnk"^)
echo oShellLink.TargetPath="%%ProgramFiles%%\Internet Explorer\iexplore.exe"
echo oShellLink.Arguments="-nohome"
echo oShellLink.WorkingDirectory="%%HOMEDRIVE%%%%HOMEPATH%%"
echo oShellLink.WindowStyle=1
echo oShellLink.Description="查找并显示 Internet 上的信息和网站。"
echo oShellLink.Save)>makelnk.vbs
makelnk.vbs
del /f /q makelnk.vbs
::在桌面创建百度快捷方式
echo [InternetShortcut] >%USERPROFILE%\Desktop\百度.url
echo URL="https://www.baidu.com/?tn=baiduhome" >>%USERPROFILE%\Desktop\百度.url

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



:: 7.浏览器相关设置
::关闭Microsoft Edge“首次运行”欢迎页面
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge" /v "PreventFirstRunPage" /t REG_DWORD /d 0 /f
::关闭Adobe Flash即点即用
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Security" /v "FlashClickToRunMode" /t REG_DWORD /d 0 /f
::解锁IE主页
reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /f >nul 2>nul
::设置IE主页 
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "https://www.baidu.com/?tn=baiduhome" /f
::关闭Smartscreen应用筛选器
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d off /t REG_SZ /f
::关闭建议的网站
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Suggested Sites" /v Enabled /t REG_DWORD /d 0 /f
::关闭多个选项卡时不发出警告
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "WarnOnClose" /t REG_DWORD /d 0 /f
::从当前窗口的新选项卡中打开外部连接
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "ShortcutBehavior" /t REG_DWORD /d 1 /f
::跳过IE首次运行自定义设置
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f
::启用表单的自动完成功能
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use FormSuggest" /d "yes" /f
::启用搜索建议
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer" /v AllowServicePoweredQSA /t REG_DWORD /d 1 /f
::锁定Internet Explorer工具栏
reg add "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /v "Locked" /t REG_DWORD /d 1 /f
::将同时可用下载数目调整到 10
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPer1_0Server" /t REG_DWORD /d 10 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPerServer" /t REG_DWORD /d 10 /f
::隐藏Internet Explorer右上角的笑脸反馈按钮
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v "NoHelpItemSendFeedback" /t REG_DWORD /d 1 /f
::关闭IE请勿追踪功能(Do Not Track) 
reg add "HKLM\Software\Policies\Microsoft\MicrosoftEdge\Main" /v DoNotTrack /t REG_DWORD /d 0 /f
::关闭定位
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v PolicyDisableGeolocation /t REG_DWORD /d 1 /f




:: 8.微软拼音输入法配置选项
::添加中文美式键盘并设为默认
reg add "HKCU\Keyboard Layout" /f
reg add "HKCU\Keyboard Layout\Preload" /v "1" /d "00000804" /f
reg add "HKCU\Keyboard Layout\Preload" /v "2" /d "d0010804" /f
reg add "HKCU\Keyboard Layout\Substitutes" /v "00000804" /d "00000409" /f
reg add "HKCU\Keyboard Layout\Substitutes" /v "d0010804" /d "00000804" /f
reg add "HKCU\Keyboard Layout\Toggle" /f
reg add "HKCU\SOFTWARE\Microsoft\CTF\Assemblies\0x00000804" /f
reg add "HKCU\SOFTWARE\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}" /v "Default" /d "{00000000-0000-0000-0000-000000000000}" /f
reg add "HKCU\SOFTWARE\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}" /v "Profile" /d "{00000000-0000-0000-0000-000000000000}" /f
reg add "HKCU\SOFTWARE\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}" /v "KeyboardLayout" /t REG_DWORD /d 67700740 /f
::微软拼音默认为英语输入
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f
::关闭微软拼音云计算
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d 0 /f
::关闭模糊音
reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "Enable Fuzzy Input" /t REG_DWORD /d 0 /f
::将语言栏隐藏到任务拦
reg add "HKCU\Software\Microsoft\CTF\LangBar" /v "ShowStatus" /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Microsoft\CTF\LangBar"  /v "ExtraIconsOnMinimized" /t REG_DWORD /d 0 /f
::隐藏语言栏上的帮助按钮
reg add "HKCU\Software\Microsoft\CTF\LangBar\ItemState\{ED9D5450-EBE6-4255-8289-F8A31E687228}" /v "DemoteLevel" /t REG_DWORD /d 3 /f



:: 9.开始菜单以及Windows体验
::关闭小娜
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
::关闭“突出显示新安装的程序”
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_NotifyNewApps" /t REG_DWORD /d "0" /f
::关闭游戏录制工具
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
::关闭锁屏时的Windows 聚焦推广
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnable" /t REG_DWORD /d "0" /f
::关闭“使用Windows时获取技巧和建议”
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
::关闭商店应用推广
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f
::禁止自动安装推荐的应用程序
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
::禁止在开始菜单显示建议
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f
::关闭推送安装服务
Reg add "HKLM\SOFTWARE\Policies\Microsoft\PushToInstall" /v "DisablePushToInstall" /t REG_DWORD /d "1" /f
::关闭更新的自动下载和安装
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f
::关闭在应用商店中查找关联应用
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d 1 /f
::关闭Microsoft 消费者体验
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
schtasks /Change /DISABLE /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" >nul
Start /wait schtasks.exe /Change /DISABLE /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" >nul



:: 10.电源管理
::启用休眠
powercfg -h on
::将休眠文件直接压缩到内存容量的最低，即：40%
powercfg -h size 40
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
::开启快速启动
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /d 1 /t REG_DWORD /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /d 1 /t REG_DWORD /f



:: 11.系统属性：启动和故障恢复
::开机：设置开机磁盘扫描等待时间为2秒
chkntfs /t:2
::开机：设置开机显示操作系统列表时间3秒 %systemroot%\system32\bcdedit.exe /timeout 3
bcdedit /timeout 3
::系统失败：写入调试信息：禁止内存转储
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /d 0 /t REG_DWORD /f
::系统失败：禁止将事件写入系统日志
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "LogEvent" /d 0 /t REG_DWORD /f
::禁用系统日志
reg add "HKCU\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /d 1 /t REG_DWORD /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /d 1 /t REG_DWORD /f
::禁用账号登录日志报告
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "ReportBootOk" /d "0" /f
::禁用WfpDiag.ETL日志
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options" /v "CollectNetEvents" /d 0 /t REG_DWORD /f
::禁用组件堆栈（Component Based Servicing）文件备份
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /v "DisableComponentBackups" /d 1 /t REG_DWORD /f
:: 11.系统属性：系统还原
::关闭系统保护并删除还原点
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR" /d 1 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer" /v "LimitSystemRestoreCheckpointing" /d 1 /t REG_DWORD /f
:: 11.系统属性：关闭远程协助
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowToGetHelp" /d 0 /t REG_dword /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowUnsolicited" /d 0 /t REG_dword /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fDenyTSConnections" /d 1 /t REG_dword /f



:: 12.系统APP默认设置项调整
::记事本显示状态栏
reg add "HKCU\Software\Microsoft\NotePad" /v "StatusBar" /t REG_DWORD /d 1 /f
::记事本自动换行
reg add "HKCU\Software\Microsoft\NotePad" /v "fwrap" /t REG_DWORD /d 1 /f
::键盘记住上次NumLock状态
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /d "2" /f
::Windows Media Player 不显示首次使用对话框
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer /v "GroupPrivacyAcceptance" /t REG_DWORD /d 1 /f
::退出程序时自动清理内存中的DLL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v AlwaysUnloadDll /t REG_DWORD /d 00000001 /f
::自动关闭停止响应的程序
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /d "1" /f
::减少关机前的程序等待
reg add "HKEY_USERS\.DEFAULT\Control Panel\Desktop" /v "HungAppTimeout" /d "200" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Desktop" /v "WaitToKillAppTimeout" /d "1000" /f
::执行关机时强制退出应用程序（关机时强杀后台不等待）
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /d 0 /t REG_SZ /f



:: 13.其他设置调整 My Opt
::清理启动项
attrib -s -h -r "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\*.*" 1>nul 2>nul
attrib -s -h -r "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
attrib -s -h -r "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\*.*" 1>nul 2>nul
del /f /q "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
del /f /q "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.*" 1>nul 2>nul
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



echo 更新策略
gpupdate /force
ping -n 3 127.0.0.1>nul
cls
del "%userprofile%\AppData\Local\iconcache.db" /f /q
taskkill /f /im explorer.exe
start %systemroot%\explorer
start explorer
exit
