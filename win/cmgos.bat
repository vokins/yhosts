@ECHO OFF
rem 15:19 2018/8/27
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 10 神州网信政府版 调整工具
COLOR 0a

rem 根据 http://document.cmgos.com/release_notes/release_notes_V0_H 此发行版做了适当适配

::服务调整部分： 未禁用：Application Management
::Connected User Experiences and Telemetry
sc config DiagTrack start= disabled
::Diagnostic Policy Service
sc config DPS start= disabled
::Remote Registry
sc config RemoteRegistry start= disabled
::Problem Reports and Solutions Control Panel Support
sc config wercplsupport start= disabled
::Fax
sc config Fax start= disabled
::Performance Logs & Alerts
sc config pla start= disabled
::Windows Error Reporting Service
sc config WerSvc start= disabled

::a.     移除了下列应用/服务：（保留：Desktop App Installer、Store Purchase App、钱包、应用商店、Xbox、Windows To Go） 
::天气
PowerShell "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
::获取帮助
PowerShell "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
::Get Started
PowerShell "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
::消息
PowerShell "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
::Office Hub
PowerShell "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
::Microsoft Solitaire Collection
PowerShell "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
::Sticky Notes
PowerShell "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
::Office OneNote
PowerShell "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"
::人脉
PowerShell "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
::闹钟和时钟
PowerShell "Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage"
::连接
PowerShell "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"
::反馈中心
PowerShell "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
::地图
PowerShell "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"
::语音录音机
PowerShell "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
::Groove音乐
PowerShell "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
::电影和电视
PowerShell "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"


cd /d "%~dp0"
CLS
install_wim_tweak.exe /o /l
::Cortana
install_wim_tweak.exe /o /c "Microsoft-Windows-Cortana" /r
::混合现实门户
install_wim_tweak.exe /o /c "Microsoft-Windows-Holographic-Desktop" /r
::Edge
install_wim_tweak.exe /o /c "Microsoft-Windows-Internet-Browser" /r
::Windows Defender 防病毒
install_wim_tweak.exe /o /c "Windows-Defender" /r
::Quick Assist
install_wim_tweak.exe /o /c "Microsoft-Windows-QuickAssist" /r

::b.    禁用了下列应用/服务：(不清楚怎么调整的部分：Administrative Shares、Internet Information Services、Microsoft Message Queue、ASP.NET 4.7、容器、)
::Fax and Scan
install_wim_tweak.exe /o /c "Microsoft-Windows-Fax" /r
::Windows Media Player
install_wim_tweak.exe /o /c "Microsoft-Windows-MediaPlayer" /r
install_wim_tweak.exe /o /c "Microsoft-Windows-WindowsMediaPlayer" /r
::Windows Hello
install_wim_tweak.exe /o /c "Microsoft-Windows-Hello" /r
::远程桌面
install_wim_tweak.exe /o /c "Microsoft-Windows-RemoteDesktop" /r
install_wim_tweak.exe /o /c "RemoteDesktopServices-Base" /r
::简单 TCPIP 服务(即echo、daytime等)
install_wim_tweak.exe /o /c "Microsoft-Windows-SimpleTCP" /r
::简单网络管理协议(SNMP) 
install_wim_tweak.exe /o /c "Microsoft-Windows-SNMP" /r
install_wim_tweak.exe /o /c "Microsoft-Windows-WMI-SNMP-Provider" /r
::SMB 1.0/CIFS 文件共享支持、
install_wim_tweak.exe /o /c "Microsoft-Windows-SMB1" /r
::Telnet 客户端
install_wim_tweak.exe /o /c "Microsoft-Windows-Telnet" /r
::TFTP 客户端
install_wim_tweak.exe /o /c "Microsoft-Windows-TFTP" /r
::Hyper-V
install_wim_tweak.exe /o /c "Microsoft-Hyper-V" /r
install_wim_tweak.exe /o /c "Microsoft-Windows-RemoteFX" /r
install_wim_tweak.exe /o /c "Microsoft-Windows-Virtual" /r
::Active Directory 轻型目录服务
install_wim_tweak.exe /o /c "Microsoft-Windows-DirectoryServices-ADAM-Client" /r
install_wim_tweak.exe /o /c "microsoft-windows-directoryservices-adam-snapins" /r
::NFS
install_wim_tweak.exe /o /c "Microsoft-Windows-NFS" /r

install_wim_tweak.exe /h /o /l

exit