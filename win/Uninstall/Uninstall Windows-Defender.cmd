@echo off
cd /d "%~dp0"
echo Uninstalling Windows-Defender...
CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c "Windows-Defender" /r
install_wim_tweak.exe /h /o /l
echo It should be uninstalled. Please reboot Windows 10.
::³¹µ×ÒÆ³ýWindows-Defender
echo y|takeown /f "%windir%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\Assets\*.*"
echo y|icacls "%windir%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\Assets\*.*" /grant administrators:F
rd /s /q "%windir%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\Assets\"
echo y|takeown /f "%ProgramFiles%\Windows Defender\*.*"
echo y|icacls "%ProgramFiles%\Windows Defender\*.*" /grant administrators:F
rd /s /q "%ProgramFiles%\Windows Defender\"
echo y|takeown /f "%ProgramFiles%\Windows Defender Advanced Threat Protection\*.*"
echo y|icacls "%ProgramFiles%\Windows Defender Advanced Threat Protection\*.*" /grant administrators:F
rd /s /q "%ProgramFiles%\Windows Defender Advanced Threat Protection\"
taskkill /im smartscreen.exe /f
echo y|takeown /f "%windir%\System32\smartscreen.exe"
echo y|icacls "%windir%\System32\smartscreen.exe" /grant administrators:F
del "%windir%\System32\smartscreen.exe" /f
reg add "HKLM\SYSTEM\ControlSet001\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
END