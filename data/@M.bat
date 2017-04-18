ver=下午6:11 2017/4/18
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
del /f hosts grd.txt hosts.txt
call :del
rem call :bat
call :xunlei
call :lyq
rem call :data
rem "%~dp0win\dos2unix.exe" -n 1A.txt hosts.txt
call :winhosts
ping -n 3 127.0.0.1
call :del
del /f pop.txt union.txt app.txt
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
echo 127.0.0.1 %str%.logic.cpm.cm.kankan.com>>xunlei.txt
echo.
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
goto :eof

:lyq
@SET CURRENTDIR=%cd%
@cd..
@SET win=%cd%\win
@cd %CURRENTDIR%
rem "%win%\sed.exe" -i "$d" site.txt
set files=direct.txt active.txt base.txt down.txt error.txt hijack.txt app.txt sitecn.txt sitefor.txt pop.txt union.txt xunlei.txt
for %%a in (%files%) do (type "%%a">>hosts.txt)
set files=direct.txt active.txt base.txt down.txt error.txt hijack.txt android.txt app.txt sitecn.txt sitefor.txt pop.txt union.txt tvbox.txt xunlei.txt
for %%a in (%files%) do (type "%%a">>lyq.txt)
"%win%\sed.exe" -i "/^#/d" lyq.txt
"%win%\sed.exe" -i "/^@/d" lyq.txt
"%win%\sed.exe" -i "1,2d" lyq.txt
echo.>Version.txt
echo #version=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>>Version.txt
rem echo ;version=%time% %date%>>Version.txt
echo #url=https://github.com/vokins/yhosts>>Version.txt
set files=Version.txt lyq.txt
for %%a in (%files%) do (type "%%a">>hosts)
rem 部分路由器无法添加localhost 故删除此行。"%~dp0win\sed.exe" -i "1i\127.0.0.1 localhost" hosts
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
