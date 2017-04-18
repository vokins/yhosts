@echo off
ver=下午5:27 2017/4/18
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo.&Echo 请使用右键“以管理员身份运行”&&Pause >NUL&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
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
del /f xunlei.txt hosts.txt hosts grd.txt hbhosts.txt
goto :eof

:xunlei
set /a str+=1
echo 127.0.0.1 %str%.logic.cpm.cm.kankan.com>>xunlei.txt
echo.
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
goto :eof

:downgrd
rem wget -c --no-check-certificate -O grd.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts -e use_proxy=yes -e http_proxy=127.0.0.1:9666
wget -c --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt
wget -c --no-check-certificate -O 1.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts
wget -c --no-check-certificate -O 2.txt https://raw.githubusercontent.com/sy618/hosts/master/FQ
copy /a 1.txt + 2.txt grd.txt
rem 删除前13行注释内容
sed -i "1,13d" grd.txt
rem 删除广告域名
rem sed -i "/googlesyndication/d" grd.txt
sed -i "/googleadservices/d" grd.txt
rem sed -i "/127.0.0.1/d" grd.txt
rem 删除所有#注释行
sed -i "/^#/d" grd.txt
rem 把TAB符替换为空格符
sed -i "s/\t/ /g" grd.txt
rem 删除空行
sed -i "/^$/d" grd.txt
rem 添加作者信息
sed -i "1i\@racaljk/hosts" grd.txt
goto :eof

:winhosts
TAKEOWN /F %windir%\System32\drivers\etc >nul 2>nul
echo y|CACLS %windir%\system32\drivers\etc/t /C /p everyone:f >nul 2>nul
copy /a hosts.txt + grd.txt hbhosts.txt
copy /y "%~dp0hbhosts.txt" "%windir%\system32\drivers\etc\hosts"
ipconfig /flushdns
goto :eof
