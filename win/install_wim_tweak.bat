@echo off

:联系支持
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-ContactSupport
:Windows反馈
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-WindowsFeedback
:EDGE的SKYPE在线通话插件
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Skype-ORTC
:XBOX相关
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Xbox-GameCallableUI
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Xbox-IdentityProvider
:OneDirve安装文件
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-OneDrive-Setup
:离线文件
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-OfflineFiles
:移动中心
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MobilePC

:系统还原
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-SystemRestore
:旧版功能DirectPlay
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-DirectPlay

:远程差分压缩API支持
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RDC
:XPS查看器
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Xps
:XPS服务
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Printing-XPSServices
:RAS连接管理器管理工具包（CMAK）
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RasCMAK
:RIP侦听器
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RasRip


:工作文件夹客户端
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-EnterpriseClientSync
:Multipoint Connector
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MultiPoint-Connector

:隔离用户模式（服务器相关）
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-IsolatedUserMode
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-OneCore-IsolatedUserMode-Required
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-IsolatedUserMode-Opt

:MSMQ服务器
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-COM-MSMQ
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MSMQ-Client
:Microsoft-Windows-NetFx-Shared-WCF-MsmqActivation


echo 删除连接
install_wim_tweak.exe /o /c "Microsoft-PPIProjection" /r


echo Please reboot Windows 10.
pause&exit




