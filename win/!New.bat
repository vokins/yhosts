

:: gpedit.msc  C:\Windows\System32\GroupPolicy

TITLE 使用：默认选项调整&完善

echo Fix CHM
regsvr32 /s hhctrl.ocx
regsvr32 /s itircl.dll
regsvr32 /s itss.dll

echo 复制Notepad2
copy /y "Notepad2.exe" "%SystemRoot%" >nul 2>nul
echo 将Notepad劫持为Notepad2
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /d "\"C:\Windows\Notepad2.exe\" /z" /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /f >nul 2>nul
echo 添加：文件：用记事本打开（97）imageres.dll,289 (按Shift显示)
reg add "HKCR\*\shell\Noteped" /ve /d "用记事本打开" /f
reg add "HKCR\*\shell\Noteped" /v "icon" /d "SHELL32.dll,70" /f
reg add "HKCR\*\shell\Noteped" /v "Extended" /d "" /f
reg add "HKCR\*\shell\Noteped\command" /ve /d "Notepad2.exe %%1" /f

echo 在控制面板添加 编辑注册表 项
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "编辑注册表" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "InfoTip" /d "打开注册表编辑器" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "System.ControlPanel.Category" /d "5" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\DefaultIcon" /ve /d "%%SystemRoot%%\regedit.exe" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\Shell\Open\command" /ve /d "regedit" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "添加注册表编辑器" /f

echo 添加LRC歌词格式识别
reg add "HKCR\.lrc" /ve /d "lrcfile" /f
reg add "HKCR\.lrc" /v "PerceivedType" /d "text" /f
reg add "HKCR\lrcfile" /ve /d "lrc 歌词" /f
reg add "HKCR\lrcfile\DefaultIcon" /ve /d "imageres.dll,17" /f
reg add "HKCR\lrcfile\shell" /f
reg add "HKCR\lrcfile\shell\open" /f
reg add "HKCR\lrcfile\shell\open\command" /ve /d "NOTEPAD.EXE %%1" /f

echo 默认使用Chrome打开MHT
reg add "HKCR\.mht" /ve /d "ChromeHTML" /f
echo 默认使用Chrome打开PDF
reg add "HKCR\.pdf" /ve /d "ChromeHTML" /f



echo 关闭Smartscreen筛选器
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /d "Off" /f


echo 关闭打开 本地 文件的“安全警告”
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /d ".7z;.cab;.bat;.chm;.cmd;.exe;.js;.msi;.rar;.reg;.vbs;.zip;.txt" /f

::微软拼音输入法
echo 微软拼音默认为英语输入
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f
echo 关闭从云中获取候选词
rem 关闭微软拼音云计算
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d 0 /f
echo 关闭从云中获取贴纸
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "EnableLiveSticker" /t REG_DWORD /d 0 /f
echo 关闭模糊音
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Fuzzy Input" /t REG_DWORD /d 0 /f
echo 关闭显示新词热词搜索的提示
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Hot And Popular Word Search" /t REG_DWORD /d 0 /f

::禁掉 Hyper-V (To enable: bcdedit /set hypervisorlaunchtype auto)
rem To disable: 
bcdedit /set hypervisorlaunchtype off

:: 系统 ：关闭Windows日志文件
echo 禁用错误报告(Windows Error Reporting Service)
sc config WerSvc start= disabled
echo 禁用WfpDiag.ETL日志
netsh wfp set options netevents = off
echo 禁用Dirty shutdown event日志
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 0 /f
echo 禁用系统日志
reg add "HKCU\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
echo 禁用账号登录日志报告
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "ReportBootOk" /d "0" /f

::记事本
echo 记事本始终显示状态栏
reg add "HKCU\Software\Microsoft\NotePad" /v "StatusBar" /t REG_DWORD /d 1 /f
echo 记事本启用自动换行
reg add "HKCU\Software\Microsoft\NotePad" /v "fwrap" /t REG_DWORD /d 1 /f

::WMPlayer
echo Windows Media Player 不显示首次使用对话框
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "GroupPrivacyAcceptance" /t REG_DWORD /d 1 /f > NUL 2>&1

::Windows PhotoViewer
echo 启用 Windows 照片查看器
reg add "HKCU\Software\Classes\.bmp" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.gif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.ico" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.jpe" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.jpeg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.jpg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.png" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.tga" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.tif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.tiff" /ve /d "PhotoViewer.FileAssoc.Tiff" /f




echo 蓝屏时自动重启
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 1 /f

echo 增加 卓越性能电源模式


::ezbsystems http://www.ezbsystems.com/ultraiso/download.htm
echo UltraISO 注册
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "UserName" /d "累累" /f
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "Registration" /d "67693a0a733a6e6c111c4e06733c6b1f" /f

::Magix.com
echo Vegas 默认使用内置中文语言
reg add "HKLM\SOFTWARE\Sony Creative Software\Error Reporting Client\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\Sony Creative Software\Sony Vegas OFX GPU Video Plug-in Pack\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\Sony Creative Software\Sony Vegas Video Plug-In Pack\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\Sony Creative Software\VEGAS Pro\15.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\Sony Creative Software\VEGAS Pro\16.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Sony Creative Software\SfTrans1\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Sony Creative Software\Sony Vegas Video Plug-In Pack\1.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Sony Creative Software\Video Capture\6.0\Lang" /v "ULangID" /t REG_DWORD /d 2052 /f
echo R2R补丁信息完善
reg add "HKCU\SOFTWARE\TEAM R2R\Protein Emulator" /v "Name" /d "MAGIX Software GmbH" /f
reg add "HKCU\SOFTWARE\TEAM R2R\Protein Emulator" /v "SerialNumber" /d "P-1-305-722-5810" /f

::WinRAR
echo WinRAR 去掉右键菜单中添加的“压缩...并 E-Mail”
reg add "HKCU\SOFTWARE\WinRAR\Setup\MenuItems" /v "EmailArc" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\WinRAR\Setup\MenuItems" /v "EmailOpt" /t REG_DWORD /d 0 /f
echo WinRAR 锁定工具栏
reg add "HKCU\Software\WinRAR\General\Toolbar" /v "Lock" /t REG_DWORD /d 1 /f
echo WinRAR 默认压缩格式
reg add "HKCU\Software\WinRAR\Profiles\0" /v "RAR5" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\WinRAR\Profiles\0" /v "Default" /t REG_DWORD /d 1 /f

::劫持一些修改主页和后台下载推广的文件
rem 2345
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345MiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\2345PicMiniPage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Downloader_2345Explorer.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HaoZipHomePage.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wzdh2345.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Pic_2345Svc.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Helper_2345Pic.exe" /v Debugger /t REG_SZ /d "p" /f
rem 360
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\360wallpaper_360safe.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\360zipInst.exe" /v Debugger /t REG_SZ /d "p" /f
rem Baofeng
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BFBrowser.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BFDesktopTips.exe" /v Debugger /t REG_SZ /d "p" /f
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BFpop.exe" /v Debugger /t REG_SZ /d "p" /f
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\InfoTips.exe" /v Debugger /t REG_SZ /d "p" /f
rem Chrome
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\software_reporter_tool.exe" /v Debugger /t REG_SZ /d "p" /f
rem Flash
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FlashHelperService.exe" /v Debugger /t REG_SZ /d "p" /f
rem iQIYI
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QyFragment.exe" /v Debugger /t REG_SZ /d "p" /f
rem KingSoft
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\install_duba.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\install_ksafe.exe" /v Debugger /t REG_SZ /d "p" /f
rem wps
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\desktoptip.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wpsnotify.exe" /v Debugger /t REG_SZ /d "p" /f
rem DriverGenius
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\kbasesrv_setup.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\kdsminisite.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\kinstallsoftware.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\kminisite.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\kminisitebox.exe" /v Debugger /t REG_SZ /d "p" /f
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\kybox.exe /v Debugger /t REG_SZ /d "p" /f
rem KingSoft-iciba
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ksddownloader.exe" /v Debugger /t REG_SZ /d "p" /f
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ktpcntr.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\minisite.exe" /v Debugger /t REG_SZ /d "p" /f
rem Sogou
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SohuNews.exe" /v Debugger /t REG_SZ /d "p" /f
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SogouCloud.exe" /v Debugger /t REG_SZ /d "p" /f
rem QQ
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QQPcmgrDownload.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\pcmgr_down.exe" /v Debugger /t REG_SZ /d "p" /f
rem TaoBao
::reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Dandelion.exe" /v Debugger /t REG_SZ /d "p" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DandelionSetup.exe" /v Debugger /t REG_SZ /d "p" /f
rem Pops
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\KuaizipUpdate.exe" /v Debugger /t REG_SZ /d "p" /f
rem Glarysoft
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GUDownloader.exe" /v Debugger /t REG_SZ /d "p" /f

echo 重置网络连接
netsh advfirewall reset
netsh int ip reset
netsh winhttp reset proxy
netsh winsock reset
ipconfig /flushdns
echo 网络参数优化
echo 禁用 Receive Window Auto-Tuning Level（接收窗口自动调节级别）
rem 复    原 netsh int tcp set global autotuninglevel=normal
rem 查看状态 netsh interface tcp show global
netsh int tcp set global autotuninglevel=disabled
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d 65535 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxFreeTcbs" /t REG_DWORD /d 65536 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxHashTableSize" /t REG_DWORD /d 8192 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d 65534 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPWindowSize" /t REG_DWORD /d 62420 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30 /f



:: 服务调整部分：Win默认禁用的服务：AppVClient NetTcpPortSharing ssh-agent RemoteRegistry RemoteAccess shpamsvc tzautoupdate UevAgentService
::禁用使用情况信息的收集和传输
::Connected User Experiences and Telemetry
net stop DiagTrack
sc config DiagTrack start=disabled
echo Data Sharing Service
sc config DsSvc start=disabled
echo Diagnostic Execution Service
sc config diagsvc start=disabled
echo 禁用诊断服务 Diagnostic Policy Service
net stop DPS
sc config DPS start=disabled
echo 禁用远程修改注册表
sc config RemoteRegistry start=disabled
echo 禁用程序兼容性助手 Program Compatibility Assistant Service
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /d 1 /t REG_DWORD /f >nul 2>nul
sc config PcaSvc start=disabled
::Diagnostic Service Host
sc config WdiServiceHost start=disabled
::Diagnostic System Host
sc config WdiSystemHost start=disabled
::dmwappushsvc
sc config dmwappushservice start=disabled
::Microsoft (R) 诊断中心标准收集器服务
sc config diagnosticshub.standardcollector.service start=disabled
::Performance Logs & Alerts
sc config pla start=disabled
::Problem Reports and Solutions Control Panel Support
sc config wercplsupport start=disabled

::Hyper-V
sc config HvHost start=disabled
sc config vmickvpexchange start=disabled
sc config vmicguestinterface start=disabled
sc config vmicshutdown start=disabled
sc config vmicheartbeat start=disabled
sc config vmicvmsession start=disabled
sc config vmictimesync start=disabled
sc config vmicvss start=disabled
sc config vmicrdv start=disabled

::Xbox
rem Xbox Accessory Management Service
sc config XboxGipSvc start=disabled
rem Xbox Game Monitoring
rem sc config xbgm start= demand
rem Xbox Live 身份验证管理器
sc config XblAuthManager start=disabled
rem Xbox Live 网络服务
sc config XboxNetApiSvc start=disabled
rem Xbox Live 游戏保存
sc config XblGameSave start=disabled
rem 禁用 XBOX GameDVR
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f > NUL 2>&1

::Fax
sc config Fax start=disabled
::Distributed Link Tracking Client
sc config TrkWks start=disabled
::Downloaded Maps Manager
sc config MapsBroker start=disabled
::Geolocation Service
sc config lfsvc start=disabled
::Phone Service
sc config PhoneSvc start=disabled


::Shell Hardware Detection
sc config ShellHWDetection start=disabled
::Remote Registry(远程修改注册表)
sc config RemoteRegistry start=disabled
::Superfetch
net stop SysMain
sc config SysMain start=disabled
::Windows Media Player Network Sharing Service
sc config WMPNetworkSvc start=disabled
::Windows Search
net stop WSearch
taskkill /f /im SearchUI.exe > NUL 2>&1
sc config WSearch start=disabled
::零售演示服务
sc config RetailDemo start=disabled

::国内服务
sc config QQMusicService start=disabled > NUL 2>&1
sc config QiyiService start=disabled > NUL 2>&1
sc config wpscloudsvr start=disabled > NUL 2>&1

:: 任务计划程序调整 %windir%\system32\taskschd.msc /s
::Microsoft 客户体验改善计划
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64 Critical"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 Critical"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319"
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
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Feedback\Siuf\DmClient"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Location\Notifications"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Location\WindowsActionDialog"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maintenance\WinSAT"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maps\MapsToastTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maps\MapsUpdateTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\RetailDemo\CleanupOfflineContent"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\WDI\ResolutionHost"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
::Windows Defender
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
::驱动器优化和碎片整理
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"
::自动磁盘清理
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup"
::XblGameSaveTask
SCHTASKS /Change /Disable /TN "\Microsoft\XblGameSave\XblGameSaveTask"
::Adobe
SCHTASKS /Change /DISABLE /TN "\AdobeAAMUpdater-1.0-%computername%-%username%" > NUL 2>&1
::Office遥测代理的后台任务
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\Office 15 Subscription Heartbeat" > NUL 2>&1
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" > NUL 2>&1
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" > NUL 2>&1

echo Windows更新清理
rem net stop wuauserv
del /s /q /f %windir%\SoftwareDistribution\Download\*.*
del /s /q /f %windir%\SoftwareDistribution\DataStore\*.*
rem net start wuauserv
start ms-settings:windowsupdate

cls
echo 更新策略
gpupdate /force 
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
ping -n 3 127.0.0.1>nul
echo 关闭explorer.exe
taskkill /f /im explorer.exe > NUL 2>&1
echo 清理 系统托盘记忆的图标
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams > NUL 2>&1
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream > NUL 2>&1
echo 清理系统图标缓存数据库
attrib -h -s -r "%userprofile%\AppData\Local\IconCache.db" > NUL 2>&1
del /f "%userprofile%\AppData\Local\IconCache.db" > NUL 2>&1
attrib /s /d -h -s -r "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*" > NUL 2>&1
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" > NUL 2>&1
echo 打开explorer
start explorer
