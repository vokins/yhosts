@echo off 
color 0a
title Windowsϵͳ��������
echo �������ϵͳ�����ļ������Ե�......
echo ɾ��ϵͳ��Ŀ¼����ʱ�ļ�
del /f /s /q "%systemdrive%\*.tmp"
del /f /s /q "%systemdrive%\*._mp"
del /a /f /s /q "%SystemRoot%\*.dmp"
echo ɾ�����õĴ��̼���ļ� (ϵͳ����)����
del /a /f /q "%SystemDrive%\*.chk"
echo ɾ��ϵͳ��Ŀ¼����־�ļ�
del /f /s /q "%systemdrive%\*.log"
echo ��ջ���վ
del /f /s /q %systemdrive%\$Recycle.Bin\*.*
echo ɾ��Ӧ�ó�����ʱ�ļ� 
del /f /s /q "%windir%\prefetch\*.*"
del /a /f /s /q "%SystemRoot%\Prefetch\*.*"
del /a /f /s /q "%SystemRoot%\minidump\*.*"
echo ɾ��ϵͳ������ʱ�ļ� 
del /f /s /q "%windir%\SoftwareDistribution\*.*"
rd /s /q "%SystemRoot%\SoftwareDistribution\Download"
echo ɾ��ϵͳά���Ȳ�����������ʱ�ļ� 
rd /s /q "%SystemRoot%\temp" & md "%SystemRoot%\temp"
rd /s /q "%SystemRoot%\Downloaded Program Files"
rd /s /q "%SystemRoot%\Offline Web Pages"
echo ɾ��internet��ʱ�ļ� 
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
echo ɾ����ǰ�û��ճ�������ʱ�ļ� 
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /a /f /s /q "%Temp%\*.*"
echo ���ϵͳ������ɣ�
echo hosts���³ɹ�
ping -n 3 127.0.0.1>nul