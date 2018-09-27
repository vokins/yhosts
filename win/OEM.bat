@ECHO OFF
::OEM信息
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Manufacturer" /d "Sky Eiga Inc." /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Model" /d "ASUS TUF X470-PLUS + SAPPHIRE RX580 8G D5 + KLEVV DDR4 3000" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "SupportPhone" /d "（ASUS）400-620-6655  （MSI）400-828-8588" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "SupportURL" /d "https://www.asus.com.cn/supportonly/TUF X470-PLUS GAMING/HelpDesk_Download/" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "SupportHours" /d "（ASUS） 00:00 - 24:00   （MSI）  9:00 - 18:00    /   周一至周日" /f
::copy /y "OEMLOGO.bmp" "%SystemRoot%\System32"
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "logo" /d "C:\Windows\System32\OEMLOGO.bmp" /f
