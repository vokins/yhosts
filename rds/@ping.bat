@echo off
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
taskkill /f /t /im pinginfoview.exe
taskkill /f /t /im ping.exe
set files=archive.txt cdn.txt ea.txt facebook.txt feedly.txt firefox.txt flipboard.txt foursquare.txt friendfeed.txt github.txt google.txt greatfire.txt picture.txt search.txt soundcloud.txt speedtest.txt steam.txt storage.txt torproject.txt twitter.txt userstyles.txt wiki.txt wordpress.txt xmarks.txt yahoo.txt youtube.txt
for %%a in (%files%) do (type "%%a">>1A.txt)
for /f "delims=" %%a in (1A.txt) do (for /f "tokens=2 delims=[]" %%i in ('ping /n 1 %%a') do echo %%i %%a >>grd.txt)
del /f 1A.txt
move /y grd.txt "%~dp0..\data"
exit
@echo on&SetLocal EnableDelayedExpansion
(For /f "delims=" %%i in (1A.txt) do (For /f "delims=[] tokens=2" %%j in ('ping %%i') do echo %%j %%i))>aa.txt
pause

(for /f %%i in (1A.txt) do (
    for /f "skip=1 tokens=2 delims=[]" %%j in ('ping -n 1 %%i') do (
        echo %%j %%i
    )
))>grd.txt