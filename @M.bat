ver=19:24 2016/3/13/ÖÜÈÕ
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
del /f lyq.txt
call :del
rem call :bat
rem call :version
call :xunlei
call :downgrd
call :lyq
call :data
"%~dp0lib\dos2unix.exe" -n 1A.txt hosts
call :winhosts
ping -n 3 127.0.0.1
call :del
exit

:del
del /f Version.txt Xunlei.txt bat.txt 1A.txt
goto :eof

:bat
echo title yhosts>bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts>>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts>>bat.txt
echo goto :eof>>bat.txt
goto :eof

:version
echo.>Version.txt
echo ;version=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>>Version.txt
rem echo ;version=%time% %date%>>Version.txt
echo ;url=https://github.com/vokins/yhosts>>Version.txt
goto :eof

:xunlei
set /a str+=1
echo 127.0.0.1 %str%.biz5.sandai.net>>xunlei.txt
echo.
echo 127.0.0.1 %str%.float.sandai.net>>xunlei.txt
echo.
echo 127.0.0.1 %str%.logic.cpm.cm.sandai.net>>xunlei.txt
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
goto :eof

:data
set files=bat.txt Version.txt hosts.txt mobile.txt tvbox.txt cps.txt daohang.txt down.txt errorpage.txt xunlei.txt
for %%a in (%files%) do (type "%%a">>1A.txt)
goto :eof

:lyq
set files=hosts.txt tvbox.txt xunlei.txt
for %%a in (%files%) do (type "%%a">>lyq.txt)
goto :eof

:winhosts
TAKEOWN /F "%windir%\System32\drivers\etc" /A
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f
rem icacls "%windir%\System32\drivers\etc" /grant "NT AUTHORITY\NetworkService":RX
copy /y "%~dp0hosts.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
goto :eof

:downgrd
rem "%~dp0lib\wget.exe" -c --no-check-certificate -O grd.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts
"%~dp0lib\curl.exe" https://raw.githubusercontent.com/racaljk/hosts/master/hosts > grd.txt
"%~dp0lib\sed.exe" -i "1,18d" grd.txt
"%~dp0lib\sed.exe" -i "s/\t/ /g" grd.txt
"%~dp0lib\sed.exe" -i "s/[ ]\{2,\}/ /g" grd.txt
"%~dp0lib\sed.exe" -i "/googlesyndication/d" grd.txt
"%~dp0lib\sed.exe" -i "/googleadservices/d" grd.txt
"%~dp0lib\sed.exe" -i "/127.0.0.1/d" grd.txt
"%~dp0lib\sed.exe" -i "/^$/d" grd.txt
"%~dp0lib\sed.exe" -i "/^#/d" grd.txt
"%~dp0lib\sed.exe" -i "1i\@racaljk/hosts" grd.txt
goto :eof
