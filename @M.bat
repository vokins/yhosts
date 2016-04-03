ver=22:32 2016/4/3/周日
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
del /f hosts
call :del
rem call :bat
call :version
call :xunlei
call :downgrd
call :lyq
call :data
"%~dp0lib\dos2unix.exe" -n 1A.txt hosts.txt
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
rem echo ;url=https://github.com/vokins/yhosts>>Version.txt
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
set files=bat.txt Version.txt pc.txt mobile.txt tvbox.txt daohang.txt down.txt errorpage.txt xunlei.txt
for %%a in (%files%) do (type "%%a">>1A.txt)
goto :eof

:lyq
set files=pc.txt tvbox.txt xunlei.txt
for %%a in (%files%) do (type "%%a">>hosts)
"%~dp0lib\sed.exe" -i "/^#/d" hosts
"%~dp0lib\sed.exe" -i "/^@/d" hosts
"%~dp0lib\sed.exe" -i "1,3d" hosts
rem 部分路由器无法添加localhost 故删除此行。"%~dp0lib\sed.exe" -i "1i\127.0.0.1 localhost" hosts
goto :eof

:winhosts
TAKEOWN /F "%windir%\System32\drivers\etc" /A
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f
rem icacls "%windir%\System32\drivers\etc" /grant "NT AUTHORITY\NetworkService":RX
copy /y "%~dp0pc.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
goto :eof

:downgrd
"%~dp0lib\wget.exe" -c --no-check-certificate -O grd.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts
rem "%~dp0lib\curl.exe" https://raw.githubusercontent.com/racaljk/hosts/master/hosts > grd.txt
rem 删除前13行注释内容
"%~dp0lib\sed.exe" -i "1,13d" grd.txt
rem 删除广告域名
"%~dp0lib\sed.exe" -i "/googlesyndication/d" grd.txt
"%~dp0lib\sed.exe" -i "/googleadservices/d" grd.txt
rem "%~dp0lib\sed.exe" -i "/127.0.0.1/d" grd.txt
rem 删除所有#注释行
"%~dp0lib\sed.exe" -i "/^#/d" grd.txt
rem 把TAB符替换为空格符
"%~dp0lib\sed.exe" -i "s/\t/ /g" grd.txt
rem 删除空行
"%~dp0lib\sed.exe" -i "/^$/d" grd.txt
rem 添加作者信息
"%~dp0lib\sed.exe" -i "1i\@racaljk/hosts" grd.txt
goto :eof
