@echo off

:��ϵ֧��
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-ContactSupport
:Windows����
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-WindowsFeedback
:EDGE��SKYPE����ͨ�����
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Skype-ORTC
:XBOX���
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Xbox-GameCallableUI
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Xbox-IdentityProvider
:OneDirve��װ�ļ�
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-OneDrive-Setup
:�����ļ�
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-OfflineFiles
:�ƶ�����
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MobilePC

:ϵͳ��ԭ
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-SystemRestore
:�ɰ湦��DirectPlay
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-DirectPlay

:Զ�̲��ѹ��API֧��
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RDC
:XPS�鿴��
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Xps
:XPS����
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-Printing-XPSServices
:RAS���ӹ����������߰���CMAK��
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RasCMAK
:RIP������
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-RasRip


:�����ļ��пͻ���
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-EnterpriseClientSync
:Multipoint Connector
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MultiPoint-Connector

:�����û�ģʽ����������أ�
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-IsolatedUserMode
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-OneCore-IsolatedUserMode-Required
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-IsolatedUserMode-Opt

:MSMQ������
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-COM-MSMQ
install_wim_tweak.exe /p d:\win10 /r /c Microsoft-Windows-MSMQ-Client
:Microsoft-Windows-NetFx-Shared-WCF-MsmqActivation


echo ɾ������
install_wim_tweak.exe /o /c "Microsoft-PPIProjection" /r


echo Please reboot Windows 10.
pause&exit




