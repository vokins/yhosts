@echo off
cd /d "%~dp0"
echo Uninstalling Microsoft-PPIProjection...
rem É¾³ý Á¬½Ó
CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c "Microsoft-PPIProjection" /r
install_wim_tweak.exe /h /o /l
echo It should be uninstalled. Please reboot Windows 10.
end