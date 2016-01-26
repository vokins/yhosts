ver=10:08 2016/1/26/ÖÜ¶þ
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
call :del
call :bat
call :version
call :xunlei
call :data
"%~dp0lib\dos2unix.exe" -n 1A.txt hosts
call :winhosts
ping -n 3 127.0.0.1
call :del
del /f grd.txt
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
echo 0.0.0.0 %str%.biz5.sandai.net>>xunlei.txt
echo 0.0.0.0 %str%.float.sandai.net>>xunlei.txt
echo 0.0.0.0 %str%.logic.cpm.cm.sandai.net>>xunlei.txt
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
goto :eof

:data
set files=bat.txt Version.txt redirect.txt grd.txt hosts.txt xunlei.txt mobile.txt apponly.txt soft.txt cps.txt daohang.txt down.txt errorpage.txt
for %%a in (%files%) do (type "%%a">>1A.txt)
goto :eof

:winhosts
TAKEOWN /F "%windir%\System32\drivers\etc" /A
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f
rem icacls "%windir%\System32\drivers\etc" /grant "NT AUTHORITY\NetworkService":RX
copy /y "%~dp01A.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
goto :eof

:downgrd
"%~dp0lib\wget.exe" -c --no-check-certificate -O grd.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts
"%~dp0lib\sed.exe" -i "1,18d" grd.txt
"%~dp0lib\sed.exe" -i "s/\t/ /g" grd.txt
"%~dp0lib\sed.exe" -i "s/[ ]\{2,\}/ /g" grd.txt
"%~dp0lib\sed.exe" -i "/googlesyndication/d" grd.txt
"%~dp0lib\sed.exe" -i "/googleadservices/d" grd.txt
"%~dp0lib\sed.exe" -i "/127.0.0.1/d" grd.txt
"%~dp0lib\sed.exe" -i "/^$/d" grd.txt
"%~dp0lib\sed.exe" -i "/^#/d" grd.txt
"%~dp0lib\sed.exe" -i "1i\@redirect" grd.txt
goto :eof
