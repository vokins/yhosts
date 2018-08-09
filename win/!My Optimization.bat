@ECHO OFF
rem 17:02 2018/7/11
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 10 调整工具
COLOR 0a


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