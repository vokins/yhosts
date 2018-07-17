@ECHO OFF
rem 17:02 2018/7/11
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 10 调整工具
COLOR 0a

:: 清空剪贴版
mshta vbscript:clipboardData.SetData("text","")(close)

:: 1.服务调整部分：
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
net stop xbgm
sc config xbgm start= disabled
rem Xbox Live 身份验证管理器
sc config XblAuthManager start= disabled
rem Xbox Live 网络服务
sc config XboxNetApiSvc start= disabled
rem Xbox Live 游戏保存
sc config XblGameSave start= disabled

::关闭Windows Defender相关服务
rem 关闭Windows Defender Antivirus Network Inspection Service:帮助防止针对网络协议中的已知和新发现的漏洞发起的入侵企图
net stop WdNisSvc > NUL 2>&1
rem 关闭Windows Defender Antivirus Service:帮助用户防止恶意软件及其他潜在的垃圾软件。
net stop WinDefend > NUL 2>&1
rem 关闭Windows Defender Advanced Threat Protection Service:Windows Defender 高级威胁防护服务通过监视和报告计算机上发生的安全事件来防范高级威胁。
sc stop Sense > NUL 2>&1
net stop Sense > NUL 2>&1


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
del "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb" /s > NUL 2>&1
::禁用时间同步
rem Windows Time:维护在网络上的所有客户端和服务器的时间和日期同步。如果此服务被停止，时间和日期的同步将不可用。如果此服务被禁用，任何明确依赖它的服务都将不能启动。
sc config W32Time start= disabled
::禁用零售演示服务
rem 零售演示服务:当设备处于零售演示模式时，零售演示服务将控制设备活动。
sc config RetailDemo start= disabled


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

echo    正在禁用微软遥测相关任务计划，请稍候……
SCHTASKS /Change /TN "Microsoft\Office\Office ClickToRun Service Monitor" /disable
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /disable
SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Autochk\Proxy" /disable
SCHTASKS /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
SCHTASKS /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
SCHTASKS /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /disable
SCHTASKS /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /disable
SCHTASKS /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
SCHTASKS /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
schtasks /change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /disable
schtasks /change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
cls
echo.
echo    微软遥测相关任务计划禁用完毕！


:: 4.安全和维护相关设置：
::关闭UAC
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 00000000 /f
::关闭UAC小盾牌
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
::关闭打开  本地  文件的“安全警告”
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /d ".7z;.cab;.bat;.chm;.cmd;.exe;.js;.msi;.rar;.reg;.vbs;.zip" /f
::关闭打开 局域网 文件的“安全警告”（Internet选项：加载应用程序和不安全文件时不提示）
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t REG_DWORD /d 0 /f
::在未安装通过微软注册的杀软的情况下关闭Windows Security Center
echo 1、点击“主页”→“病毒和威胁防护”，关闭“实时保护”；
reg add "HKLM\SOFTWARE\Microsoft\Security Center\Feature" /v "DisableAvCheck" /t REG_DWORD /d 1 /f
::关闭Windows Defender Antivirus Service：帮助用户防止恶意软件及其他潜在的垃圾软件。(Windows Defender 改为手动启动)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /d 1 /t REG_DWORD /f
taskkill /f /im MSASCuil.exe
::关闭Windows Defender Firewall：Windows Defender 防火墙通过阻止未授权用户通过 Internet 或网络访问你的计算机来帮助保护计算机。
sc config MpsSvc start=disabled >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
::关闭自动播放
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
::关闭碎片整理和优化驱动器
SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" > NUL 2>&1


::隐藏导航栏 桌面 OneDrive  Windows10 自带网盘
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
::删除OneDrive
taskkill /f /im OneDrive.exe
taskkill /f /im explorer.exe
if exist %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe (
%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall
) else (
%SYSTEMROOT%\System32\OneDriveSetup.exe /uninstall
)
rd  /s /q "%USERPROFILE%\OneDrive"
rd  /s /q "%LOCALAPPDATA%\Microsoft\OneDrive"
rd  /s /q "%PROGRAMDATA%\Microsoft OneDrive"
reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
reg delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
start explorer





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


::关闭系统自动更新（手动更新）
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f



:: 14.
::禁用驱动程序数字签名认证：
bcdedit /set loadoptions DDISABLE_INTEGRITY_CHECKS
bcdedit /set TESTSIGNING ON
::启用驱动程序数字签名认证：
::bcdedit /set loadoptions DENABLE_INTEGRITY_CHECKS
::bcdedit /set TESTSIGNING OFF

:: 15.APP注册设置
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "UserName" /d "累累" /f
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "Registration" /d "67693a0a733a6e6c111c4e06733c6b1f" /f

reg add "HKCU\Software\WinRAR\Profiles\0" /v "RAR5" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\WinRAR\Profiles\0" /v "Default" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\WinRAR\General\Toolbar" /v "Lock" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\WinRAR\General\Toolbar" /v "Size" /t REG_DWORD /d 3 /f


echo 更新策略
gpupdate /force 
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
ping -n 3 127.0.0.1>nul
cls
del "%userprofile%\AppData\Local\iconcache.db" /f /q
taskkill /f /im explorer.exe
start %systemroot%\explorer
rem start explorer
exit