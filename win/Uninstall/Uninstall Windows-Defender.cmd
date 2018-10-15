@echo off
cd /d "%~dp0"
echo Uninstalling Windows-Defender...
CLS
install_wim_tweak.exe /o /l
install_wim_tweak.exe /o /c "Windows-Defender" /r
install_wim_tweak.exe /h /o /l
echo It should be uninstalled. Please reboot Windows 10.
::彻底移除Windows-Defender
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

一些题外话：
服务名mpssvc显示名Windows Defender Firewall 默认自动
服务名iphlpsvc显示名IP Helper 默认自动
这两个服务不能禁用，只能保持默认自动，否则会导致win10应用商店app安装失败。
可以这样做：app安装完后可禁用Windows Defender Firewall ，需要安装app时再自动即可。


服务名SecurityHealthService显示名Windows Defender 安全中心服务 默认自动
禁用Windows Defender 安全中心服务，不会影响Windows应用商店app的安装，
但开机会提示安全中心服务未启动的消息，
这个消息是因为删除了Windows Defender主体引起，即使设置Windows Defender 安全中心服务成自动也会提示，
所以Windows Defender 安全中心服务可以放心禁用，提示就让它提示没什么影响的。
（可以到 控制面板→系统和安全→安全和维护→关闭所有安全监视→更改安全和维护设置→去掉所有能去掉的勾选）

