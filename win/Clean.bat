@echo off 
color 0a
title Windows系统垃圾清理
echo 正在清除系统垃圾文件，请稍等......
echo 删除系统盘目录下临时文件
del /f /s /q "%systemdrive%\*.tmp"
del /f /s /q "%systemdrive%\*._mp"
del /a /f /s /q "%SystemRoot%\*.dmp"
echo 删除无用的磁盘检错文件 (系统分区)……
del /a /f /q "%SystemDrive%\*.chk"
echo 删除系统盘目录下日志文件
del /f /s /q "%systemdrive%\*.log"
echo 清空回收站
del /f /s /q %systemdrive%\$Recycle.Bin\*.*
echo 删除应用程序临时文件 
del /f /s /q "%windir%\prefetch\*.*"
del /a /f /s /q "%SystemRoot%\Prefetch\*.*"
del /a /f /s /q "%SystemRoot%\minidump\*.*"
echo 删除系统更新临时文件 
del /f /s /q "%windir%\SoftwareDistribution\*.*"
rd /s /q "%SystemRoot%\SoftwareDistribution\Download"
echo 删除系统维护等操作产生的临时文件 
rd /s /q "%SystemRoot%\temp" & md "%SystemRoot%\temp"
rd /s /q "%SystemRoot%\Downloaded Program Files"
rd /s /q "%SystemRoot%\Offline Web Pages"
echo 删除internet临时文件 
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
echo 删除当前用户日常操作临时文件 
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /a /f /s /q "%Temp%\*.*"
echo 清除系统垃圾完成！
echo hosts更新成功
ping -n 3 127.0.0.1>nul