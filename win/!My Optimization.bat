

:: 8.开始菜单以及Windows体验
::关闭锁屏时的Windows 聚焦推广
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnable" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
::关闭“使用Windows时获取技巧和建议”
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
::关闭事件追踪
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Reliability" /v "ShutdownReasonOn" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows NT\Reliability" /v "ShutdownReasonOn" /t REG_DWORD /d 0 /f

:: 9.系统APP默认设置项调整
::为桌面和资源管理器创建不同的进程
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DesktopProcess" /d "1" /t REG_DWORD /f
::在单独的进程中打开文件夹窗口
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f
::当资源管理器崩溃时则自动重启资源管理器
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /d "1" /t REG_DWORD /f
::开启资源管理器自动刷新功能
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Update" /v "UpdateMode" /d "1" /t REG_DWORD /f

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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f

:: 11.电源管理

::将休眠文件直接压缩到内存容量的最低，即：40%
powercfg -h size 40
::设置屏幕自动关闭时间为：3分钟
powercfg -x -monitor-timeout-ac 3
powercfg -x -monitor-timeout-dc 3
::设置屏幕关闭后禁止关闭硬盘
powercfg -x -disk-timeout-ac 0
powercfg -x -disk-timeout-dc 0
::设置7分钟后睡眠
powercfg -x -standby-timeout-ac 7
powercfg -x -standby-timeout-dc 7
::睡眠后禁止休眠
powercfg -x -hibernate-timeout-ac 0
powercfg -x -hibernate-timeout-dc 0

:: 12.系统属性：

::关闭远程协助
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowToGetHelp" /d 0 /t REG_dword /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowUnsolicited" /d 0 /t REG_dword /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fDenyTSConnections" /d 1 /t REG_dword /f

:: 13.安全和维护相关设置：

::关闭碎片整理和优化驱动器
SCHTASKS /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" > NUL 2>&1


::关闭Windows Defender Firewall：Windows Defender 防火墙通过阻止未授权用户通过 Internet 或网络访问你的计算机来帮助保护计算机。
rem sc config MpsSvc start=disabled >nul 会导致Store无法下载
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" /v "EnableFirewall" /d 0 /t REG_DWORD /f
::关闭自动播放
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutorun" /t REG_DWORD /d "0xFF" /f

rem .RAR文件
reg delete HKEY_CLASSES_ROOT\.rar\ShellNew /f > NUL 2>&1
rem .jnt 新建日记本
reg delete HKEY_CLASSES_ROOT\.jnt\jntfile\ShellNew /f > NUL 2>&1
rem .Briefcase 公文包
reg delete HKEY_CLASSES_ROOT\Briefcase\ShellNew /f > NUL 2>&1

::禁用 WAP 推消息路由服务
rem dmwappushsvc:WAP 推消息路由服务
sc config dmwappushservice start= disabled
::禁用电话服务
rem Phone Service 在设备上管理电话服务状态
sc config PhoneSvc start= disabled
::禁用传感器收集
rem Sensor Service 一项用于管理各种传感器的功能的传感器服务。管理传感器的简单设备方向(SDO)和历史记录。加载对设备方向变化进行报告的 SDO 传感器。如果停止或禁用了此服务，则将不会加载 SDO 传感器，因此不会发生自动旋转。来自传感器的历史记录收集也将停止。
sc config SensorService start= disabled
::禁用时间同步
rem Windows Time:维护在网络上的所有客户端和服务器的时间和日期同步。如果此服务被停止，时间和日期的同步将不可用。如果此服务被禁用，任何明确依赖它的服务都将不能启动。
sc config W32Time start= disabled
::并没什么用的服务
rem AllJoyn Router Service:路由本地 AllJoyn 客户端的 AllJoyn 消息。如果停止此服务，则自身没有捆绑路由器的 AllJoyn 客户端将无法运行。
sc config AJRouter start= disabled

::禁用电子钱包
rem WalletService:电子钱包客户端使用的主机对象
sc config WalletService start= disabled
::禁用数据使用量
rem 数据使用量:网络数据使用量，流量上限，限制背景数据，按流量计费的网络。
sc config DusmSvc start= disabled
::禁用无线电管理服务
rem 无线电管理和飞行模式服务
sc config RmSvc start= disabled



::禁用来宾服务
rem Shared PC Account Manager:Manages profiles and accounts on a SharedPC configured device
rem sc config shpamsvc start= disabled
::禁用UevAgentService
rem User Experience Virtualization Service:为应用程序和 OS 设置漫游提供支持
rem sc config UevAgentService start= disabled
rem sc config AppVClient start= disabled

::开启快速启动
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /d 1 /t REG_DWORD /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /d 1 /t REG_DWORD /f


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

::关闭系统自动更新（手动更新）
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f

::关闭商店应用推广
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f
::禁止在开始菜单显示建议
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f



:: 14.
::禁用驱动程序数字签名认证：
bcdedit /set loadoptions DDISABLE_INTEGRITY_CHECKS
bcdedit /set TESTSIGNING ON
::启用驱动程序数字签名认证：
::bcdedit /set loadoptions DENABLE_INTEGRITY_CHECKS
::bcdedit /set TESTSIGNING OFF
