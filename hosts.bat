@echo off
ver=20:59 2016/3/29/周二
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
call :del
call :xunlei
call :downgrd
call :winhosts
call :del
cls
msg %username% /time:3 "hosts文件已成功更新！"
exit

:del
del /f 1.txt xunlei.txt hbhosts.txt 2.txt
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

:downgrd
"%~dp0lib\wget.exe" -c --no-check-certificate -O 2.txt https://raw.githubusercontent.com/vokins/yhosts/master/pc.txt
"%~dp0lib\wget.exe" -c --no-check-certificate -O 1.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts
"%~dp0lib\sed.exe" -i "1,18d" 1.txt
"%~dp0lib\sed.exe" -i "s/\t/ /g" 1.txt
"%~dp0lib\sed.exe" -i "s/[ ]\{2,\}/ /g" 1.txt
"%~dp0lib\sed.exe" -i "/googlesyndication/d" 1.txt
"%~dp0lib\sed.exe" -i "/googleadservices/d" 1.txt
"%~dp0lib\sed.exe" -i "/127.0.0.1/d" 1.txt
"%~dp0lib\sed.exe" -i "/^$/d" 1.txt
"%~dp0lib\sed.exe" -i "/^#/d" 1.txt
"%~dp0lib\sed.exe" -i "1i\@racaljk/hosts" 1.txt
goto :eof

:winhosts
TAKEOWN /F "%windir%\System32\drivers\etc" /A
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f
rem icacls "%windir%\System32\drivers\etc" /grant "NT AUTHORITY\NetworkService":RX
copy /a 2.txt + 1.txt hbhosts.txt
copy /y "%~dp0hbhosts.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
goto :eof
