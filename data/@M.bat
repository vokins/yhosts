ver=���� 5:43 2016/10/6/����
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
del /f hosts grd.txt hosts.txt
call :del
rem call :bat
call :xunlei
call :downgrd
call :lyq
rem call :data
rem "%~dp0lib\dos2unix.exe" -n 1A.txt hosts.txt
call :winhosts
ping -n 3 127.0.0.1
call :del
exit

:del
del /f Version.txt Xunlei.txt bat.txt 1A.txt lyq.txt
goto :eof

:bat
echo title yhosts>bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts>>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts>>bat.txt
echo goto :eof>>bat.txt
goto :eof

:xunlei
set /a str+=1
echo 127.0.0.1 %str%.biz5.kankan.com>>xunlei.txt
echo.
echo 127.0.0.1 %str%.logic.cpm.cm.kankan.com>>xunlei.txt
echo.
echo 127.0.0.1 %str%.float.kankan.com>>xunlei.txt
echo.
rem echo 127.0.0.1 %str%.myhard.com>>xunlei.txt
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
goto :eof

:lyq
@SET CURRENTDIR=%cd%
@cd..
@SET lib=%cd%\lib
@cd %CURRENTDIR%
set files=1os.txt direct.txt active.txt down.txt error.txt virus.txt hijack.txt ios.txt mob.txt site.txt soft.txt union.txt xunlei.txt popup.txt
for %%a in (%files%) do (type "%%a">>hosts.txt)
set files=1os.txt direct.txt active.txt down.txt error.txt virus.txt hijack.txt ios.txt mob.txt site.txt soft.txt union.txt tvbox.txt xunlei.txt popup.txt
for %%a in (%files%) do (type "%%a">>lyq.txt)
"%lib%\sed.exe" -i "/^#/d" lyq.txt
"%lib%\sed.exe" -i "/^@/d" lyq.txt
"%lib%\sed.exe" -i "1,6d" lyq.txt
echo.>Version.txt
echo #version=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>>Version.txt
rem echo ;version=%time% %date%>>Version.txt
echo #url=https://github.com/vokins/yhosts>>Version.txt
set files=Version.txt lyq.txt
for %%a in (%files%) do (type "%%a">>hosts)
rem ����·�����޷����localhost ��ɾ�����С�"%~dp0lib\sed.exe" -i "1i\127.0.0.1 localhost" hosts
move /y hosts.txt "%~dp0..\"
move /y hosts "%~dp0..\"
goto :eof

:winhosts
TAKEOWN /F %windir%\System32\drivers\etc >nul 2>nul
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f >nul 2>nul
rem icacls "%windir%\System32\drivers\etc" /grant "NT AUTHORITY\NetworkService":RX
copy /y "%~dp0..\hosts.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
goto :eof

:downgrd
@SET CURRENTDIR=%cd%
@cd..
@SET lib=%cd%\lib
@cd %CURRENTDIR%
"%lib%\wget.exe" -c --no-check-certificate -O grd.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts
rem "%~dp01lib\curl.exe" https://raw.githubusercontent.com/racaljk/hosts/master/hosts > grd.txt
rem ɾ��ǰ13��ע������
"%lib%\sed.exe" -i "1,13d" grd.txt
rem ɾ���������
"%lib%\sed.exe" -i "/googlesyndication/d" grd.txt
"%lib%\sed.exe" -i "/googleadservices/d" grd.txt
rem "%lib%\sed.exe" -i "/127.0.0.1/d" grd.txt
rem ɾ������#ע����
"%lib%\sed.exe" -i "/^#/d" grd.txt
rem ��TAB���滻Ϊ�ո��
"%lib%\sed.exe" -i "s/\t/ /g" grd.txt
rem ɾ������
"%lib%\sed.exe" -i "/^$/d" grd.txt
rem ���������Ϣ
"%lib%\sed.exe" -i "1i\@racaljk/hosts" grd.txt
move /y grd.txt "%~dp0..\"
goto :eof
