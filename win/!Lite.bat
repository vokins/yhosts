@ECHO OFF
rem 18:44 2018/10/27
cd /d "%~dp0"
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
COLOR 0a

TITLE 卸载 WindowsApps

::系统-通知和操作：更新后向我显示“欢迎使用Windows体验”，并在我登陆时突出显示新增内容和建议的内容
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
::系统-通知和操作：在使用Windows时获取提示技巧和建议
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
::禁止 偶尔在开始菜单中显示建议
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
::禁止 在锁屏界面上获取花絮、提示、技巧
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
::禁止自动安装游戏与应用(关闭Microsoft消费者体验)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
::禁止自动安装推荐的应用程序(关闭内置的广告、提示、应用推荐)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
::关闭商店应用推广
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f >nul 2>nul

::关闭 打开未知文件方式时 从应用商店选择其它应用
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d 1 /f
:: 使用：时间和语言-区域和语言-国家和地区：
::调整为 中国
::reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "45" /f
::reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "CN" /f
::调整为 新加坡
::reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "215" /f >nul 2>nul
::reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "SG" /f >nul 2>nul
::调整为 美国
reg add "HKCU\Control Panel\International\Geo" /v "Nation" /d "244" /f >nul 2>nul
reg add "HKCU\Control Panel\International\Geo" /v "Name" /d "US" /f >nul 2>nul

:: 使用：微软商店Metro应用 %ProgramFiles%\WindowsApps 删除（保留：Desktop App Installer、Store Purchase App、钱包、应用商店）   
::Xbox身份认证应用：xbox identity provider https://www.microsoft.com/zh-cn/store/p/xbox-identity-provider/9wzdncrd1hkw
::重新注册全部 PowerShell Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
::首先是，一键卸载所有的不必要应用： 
::PowerShell "Get-AppxPackage | Remove-AppxPackage"(当前用户） 
::Get-AppxPackage -User username | Remove-AppxPackage(制定用户） 
::Get-AppxPackage -AllUsers | Remove-AppxPackage(所有用户）

::其次是卸载指定的应用： 
::Get-AppxPackage *AppName* | Remove-AppxPackage(当前用户，指定用户和所有用户类似于上面的代码）
::卸载商店
::PowerShell "get-appxpackage Microsoft.DesktopAppInstaller | remove-appxpackage"
::PowerShell "get-appxpackage Microsoft.StorePurchaseApp | remove-appxpackage"
::PowerShell "get-appxpackage Microsoft.WindowsStore | remove-appxpackage"
::PowerShell "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"
::3DBuilder
::PowerShell "Get-AppxPackage *Microsoft.3DBuilder* | Remove-AppxPackage"

::卸载Xbox游戏组件
::PowerShell "Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage"
::卸载游戏录制工具栏
::PowerShell "Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
::PowerShell "get-appxpackage *Microsoft.XboxGamingOverlay* | remove-appxpackage"

::资讯
PowerShell "Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage"
::天气
PowerShell "Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage"
::财经
PowerShell "Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage"
::体育
PowerShell "Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage"
::Twitter
PowerShell "Get-AppxPackage *.Twitter | Remove-AppxPackage"
::XBOX
PowerShell "Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage"
::Office Sway
PowerShell "Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage"
::Office OneNote
PowerShell "Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage"
::Office Hub
PowerShell "Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage"
::SkypeApp
PowerShell "Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage"
::网易云音乐
PowerShell "Get-AppxPackage *1F8B0F94.122165AE053F* | Remove-AppxPackage"
::获取帮助
PowerShell "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
::Get Started
PowerShell "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
::消息
PowerShell "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
::3DViewer
PowerShell "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
::Microsoft Solitaire Collection
PowerShell "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
::Sticky Notes
PowerShell "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
::MixedReality
PowerShell "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
::MSPaint
PowerShell "Get-AppxPackage *Microsoft.MSPaint* | Remove-AppxPackage"
::NetworkSpeedTest
PowerShell "Get-AppxPackage *Microsoft.NetworkSpeedTest* | Remove-AppxPackage"
::Office Lens
PowerShell "Get-AppxPackage *Microsoft.OfficeLens* | Remove-AppxPackage"
::连接
PowerShell "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"
::人脉
PowerShell "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
::Print3D
PowerShell "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage"
::RemoteDesktop
PowerShell "Get-AppxPackage *Microsoft.RemoteDesktop* | Remove-AppxPackage"
::截图和草图
PowerShell "Get-AppxPackage *Microsoft.ScreenSketch* | Remove-AppxPackage"
::Services.Store.Engagement
PowerShell "Get-AppxPackage *Microsoft.Services.Store.Engagement* | Remove-AppxPackage"
::Todos
PowerShell "Get-AppxPackage *Microsoft.Todos* | Remove-AppxPackage"
::Whiteboard
PowerShell "Get-AppxPackage *Microsoft.Whiteboard* | Remove-AppxPackage"
::图片
PowerShell "Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage"
::闹钟和时钟
PowerShell "Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage"
::相机
PowerShell "Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage"
::日历和邮件
PowerShell "Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage"
::反馈中心
PowerShell "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
::地图
PowerShell "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"
::语音录音机
PowerShell "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
::YourPhone
PowerShell "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
::Groove音乐
PowerShell "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
::电影和电视
PowerShell "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"

TITLE 卸载 OneDrive
taskkill /f /im OneDrive.exe > NUL 2>&1
%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall
rd /s /q "%UserProfile%\OneDrive" > NUL 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" > NUL 2>&1
rd /s /q "%ProgramData%\Microsoft OneDrive" > NUL 2>&1
rd /s /q "C:\OneDriveTemp" > NUL 2>&1
REG Delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG Delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG delete "HKEY_USERS\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Run" /f > NUL 2>&1
::start %systemroot%\explorer

END