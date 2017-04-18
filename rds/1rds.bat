:grd
@SET CURRENTDIR=%cd%
@cd..
@SET win=%cd%\win
@cd %CURRENTDIR%
rem "%win%\wget.exe" -c --no-check-certificate -O grd.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts -e use_proxy=yes -e http_proxy=127.0.0.1:9666
"%win%\wget.exe" -c --no-check-certificate -O grd.txt https://raw.githubusercontent.com/racaljk/hosts/master/hosts
rem "%~dp01win\curl.exe" https://raw.githubusercontent.com/racaljk/hosts/master/hosts > grd.txt
rem 删除前13行注释内容
"%win%\sed.exe" -i "1,13d" grd.txt
rem 删除广告域名
rem "%win%\sed.exe" -i "/googlesyndication/d" grd.txt
"%win%\sed.exe" -i "/googleadservices/d" grd.txt
rem "%win%\sed.exe" -i "/127.0.0.1/d" grd.txt
rem 删除所有#注释行
"%win%\sed.exe" -i "/^#/d" grd.txt
rem 把TAB符替换为空格符
"%win%\sed.exe" -i "s/\t/ /g" grd.txt
rem 删除空行
"%win%\sed.exe" -i "/^$/d" grd.txt
rem 添加作者信息
"%win%\sed.exe" -i "1i\@racaljk/hosts" grd.txt
move /y grd.txt "%~dp0..\"
goto :eof
