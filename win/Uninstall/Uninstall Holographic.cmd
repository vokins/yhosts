@echo off
cd /d "%~dp0"
echo Uninstalling Holographic-Desktop...
rem 删除 混合现实门户
CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c "Microsoft-Windows-Holographic-Desktop" /r
install_wim_tweak.exe /h /o /l
echo It should be uninstalled. Please reboot Windows 10.
end