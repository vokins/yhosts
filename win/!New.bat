@ECHO OFF
rem 17:06 2019/11/11
cd /d "%~dp0"
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
TITLE Windows 调整工具
COLOR 0a

rem gpedit.msc C:\WINDOWS\system32\GroupPolicy

call :Bcdedit
call :Chrome
call :Clipboard
call :ControlPanelRegedit
call :Desktop
call :Explorer
call :ExplorerUpdate
call :FileTypes
call :FixCHM
call :InputMethodCHS
call :InternetExplorer
call :LRCfile
call :MacTime
call :MicrosoftEdge
rem call :NetReset
call :NetShare
call :Notepad
call :Notepad2
call :PhotoViewer
call :Powercfg
call :RightMenuAdd
call :RightMenuDel
call :RightMenuShift
call :RightMenuSysTools
call :Service
call :SystemRestore
call :Taskbar
call :Taskschd
call :WMPlayer
call :WindowsApps
call :WindowsDefender
call :WindowsLog
call :WindowsUAC
call :SoftSN
call :GpUpdate
call :IconUpdate
call :OneDrive
call :WindowsUpdateClr
call :Wsreset
call :StartUp
call :NetFX35

exit

:Bcdedit
echo 启动和故障恢复：开机：设置开机磁盘扫描等待时间为1秒
chkntfs /t:1
echo 启动和故障恢复：开机：设置开机显示操作系统列表时间2秒
bcdedit /timeout 2
echo 禁止部分程序后台更新和自启动
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Vivaldi Update Notifier" /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "IgfxTray" /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Persistence" /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "RtHDVCpl" /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "StartCCC" /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /f >nul 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsWelcomeCenter" /f >nul 2>nul
goto :eof

:Chrome
echo MHT文件 打开方式添加Chrome项
reg add "HKCR\.mht" /ve /d "ChromeHTML" /f
echo PDF文件 打开方式添加Chrome项
reg add "HKCR\.pdf" /ve /d "ChromeHTML" /f
goto :eof

:Clipboard
echo 清空剪贴版
mshta vbscript:clipboardData.SetData("text","")(close)
goto :eof

:ControlPanelRegedit
echo 在控制面板添加 编辑注册表 项
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "编辑注册表" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "InfoTip" /d "打开注册表编辑器" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}" /v "System.ControlPanel.Category" /d "5" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\DefaultIcon" /ve /d "%%SystemRoot%%\regedit.exe" /f
reg add "HKCR\CLSID\{19260817-d95d-4dff-8b2b-a530db6ed982}\Shell\Open\command" /ve /d "regedit" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{19260817-d95d-4dff-8b2b-a530db6ed982}" /ve /d "添加注册表编辑器" /f
goto :eof

:Desktop
echo 在桌面显示 计算机-此电脑（我的电脑）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0
echo 在桌面显示 个人文件夹-用户（我的文档）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /f /v "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" /t REG_DWORD /d 0
echo 删除桌面Microsoft Edge快捷方式
set "reg=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
for /f "tokens=2*" %%a in ('reg query "%reg%" /v desktop') do set "desktop=%%b"
del /f /q "%desktop%\Microsoft Edge.lnk" >nul 2>nul
goto :eof

:Explorer
echo 我的电脑取消显示7个文件夹
rem "3D对象"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f > NUL 2>&1
rem "视频"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f > NUL 2>&1
rem "图片"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f > NUL 2>&1
rem "文档"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f > NUL 2>&1
rem "下载"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f > NUL 2>&1
rem "音乐"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f > NUL 2>&1
rem "桌面"
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f > NUL 2>&1
echo 不在“快速访问”中显示常用文件夹
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f
echo 不在“快速访问”中显示最近使用的文件（删除访问记录）
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f
del /f /s /q "%userprofile%\recent\*.*" > NUL 2>&1
echo 在标题栏中显示完整路径
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "FullPath" /t REG_DWORD /d 1 /f
echo 创建快捷方式不显示“快捷方式”文字
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /d "00000000" /t REG_BINARY /f
echo 显示已知文件类型的扩展名
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
reg add "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "HideFileExt" /t REG_DWORD /d 0
echo 关闭隐藏的 thumbs.db 文件中的缩略图缓存
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d 1 /f
echo 关闭缩略图的缓存
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoThumbnailCache" /t REG_DWORD /d 1 /f
echo 强制显示指定文件类型（bat,cmd,reg,exe）的扩展名
reg add "HKCR\batfile" /v "AlwaysShowExt" /d "" /f
reg add "HKCR\cmdfile" /v "AlwaysShowExt" /d "" /f
reg add "HKCR\exefile" /v "AlwaysShowExt" /d "" /f
reg add "HKCR\regfile" /v "AlwaysShowExt" /d "" /f
echo 关闭部分音频视频类型文件图片预览
rem reg delete "HKCR\.avi\ShellEx" /f >nul 2>nul
rem reg delete "HKCR\.m4a\ShellEx" /f >nul 2>nul
rem reg delete "HKCR\.mkv\ShellEx" /f >nul 2>nul
rem reg delete "HKCR\.mov\ShellEx" /f >nul 2>nul
rem reg delete "HKCR\.mp3\ShellEx" /f >nul 2>nul
rem reg delete "HKCR\.mp4\ShellEx" /f >nul 2>nul
reg delete "HKCR\.3gp\ShellEx" /f >nul 2>nul
reg delete "HKCR\.ape\ShellEx" /f >nul 2>nul
reg delete "HKCR\.flac\ShellEx" /f >nul 2>nul
reg delete "HKCR\.m4v\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mpeg\ShellEx" /f >nul 2>nul
reg delete "HKCR\.mpg\ShellEx" /f >nul 2>nul
reg delete "HKCR\.rmvb\ShellEx" /f >nul 2>nul
reg delete "HKCR\.wmv\ShellEx" /f >nul 2>nul
goto :eof

:ExplorerUpdate
echo 修复Win删除文件后刷新不及时的问题
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Update" /v "UpdateMode" /t REG_DWORD /d 0 /f
echo 菜单运行速度优化（默认值400）
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /d "100" /f
goto :eof

:FileTypes
echo 禁止 不断重复恢复默认设置
echo Microsoft.3DBuilder：File Types: .stl, .3mf, .obj, .wrl, .ply, .fbx, .3ds, .dae, .dxf, .bmp, .jpg, .png, .tga
reg add "HKCU\SOFTWARE\Classes\AppXvhc4p7vz4b485xfp46hhk3fq3grkdgjg" /v "NoOpenWith" /d "" /f
echo Microsoft Edge：
rem File Types: .htm, .html
reg add "HKCU\SOFTWARE\Classes\AppX4hxtad77fbk3jkkeerkrm0ze94wjf3s9" /v "NoOpenWith" /d "" /f
rem File Types: .pdf
reg add "HKCU\SOFTWARE\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723" /v "NoOpenWith" /d "" /f
rem File Types: .svg
reg add "HKCU\SOFTWARE\Classes\AppXde74bfzw9j31bzhcvsrxsyjnhhbq66cs" /v "NoOpenWith" /d "" /f
rem File Types: .xml
reg add "HKCU\SOFTWARE\Classes\AppXcc58vyzkbjbs4ky0mxrmxf8278rk9b3t" /v "NoOpenWith" /d "" /f
echo Microsoft Photos：
rem File Types: .3g2,.3gp, .3gp2, .3gpp, .asf, .avi, .m2t, .m2ts, .m4v, .mkv .mov, .mp4, mp4v, .mts, .tif, .tiff, .wmv
reg add "HKCU\SOFTWARE\Classes\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt" /v "NoOpenWith" /d "" /f
rem File Types: Most Image File Types
reg add "HKCU\SOFTWARE\Classes\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc" /v "NoOpenWith" /d "" /f
rem File Types: .raw, .rwl, .rw2 and others
reg add "HKCU\SOFTWARE\Classes\AppX9rkaq77s0jzh1tyccadx9ghba15r6t3h" /v "NoOpenWith" /d "" /f
echo Zune Music：File Types: .aac, .adt, .adts ,.amr, .flac, .m3u, .m4a, .m4r, .mp3, .mpa, .wav, .wma, .wpl, .zpl
reg add "HKCU\SOFTWARE\Classes\AppXqj98qxeaynz6dv4459ayz6bnqxbyaqcs" /v "NoOpenWith" /d "" /f
echo Zune Video：File Types: .3g2,.3gp, .3gpp, .avi, .divx, .m2t, .m2ts, .m4v, .mkv, .mod, .mov, .mp4, mp4v, .mpe, .mpeg, .mpg, .mpv2, .mts, .tod, .ts, .tts, .wm, .wmv, .xvid
reg add "HKCU\SOFTWARE\Classes\AppX6eg8h5sxqq90pv53845wmnbewywdqq5h" /v "NoOpenWith" /d "" /f
goto :eof

:FixCHM
echo Fix CHM
regsvr32 /s hhctrl.ocx
regsvr32 /s itircl.dll
regsvr32 /s itss.dll
goto :eof

:GpUpdate
gpupdate /force
RunDll32.exe USER32.DLL,UpdatePerUserSystemParameters
ping -n 3 127.0.0.1>nul
taskkill /f /im explorer.exe && start %systemroot%\explorer
goto :eof

:IconUpdate
taskkill /f /im explorer.exe > NUL 2>&1
echo 清理系统图标缓存数据库
attrib -h -s -r "%userprofile%\AppData\Local\IconCache.db" > NUL 2>&1
del /f "%userprofile%\AppData\Local\IconCache.db" > NUL 2>&1
attrib -h -s -r "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*.*" > NUL 2>&1
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*.db" > NUL 2>&1
start explorer
goto :eof

:InputMethodCHS
echo 微软拼音默认为英语输入
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f
echo 关闭从云中获取候选词（关闭微软拼音云计算）
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Cloud Candidate" /t REG_DWORD /d 0 /f
echo 关闭从云中获取贴纸
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "EnableLiveSticker" /t REG_DWORD /d 0 /f
echo 关闭模糊音
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Fuzzy Input" /t REG_DWORD /d 0 /f
echo 关闭显示新词热词搜索的提示
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Hot And Popular Word Search" /t REG_DWORD /d 0 /f
goto :eof

:InternetExplorer
echo Internet Explorer 跳过 IE 首次运行自定义设置
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f
echo Internet Explorer 隐藏右上角的笑脸反馈按钮
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v "NoHelpItemSendFeedback" /t REG_DWORD /d 1 /f
echo Internet Explorer 锁定工具栏
reg add "HKCU\Software\Microsoft\Internet Explorer\Toolbar" /v "Locked" /t REG_DWORD /d 1 /f
echo Internet Explorer 关闭多个选项卡时不发出警告
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "WarnOnClose" /t REG_DWORD /d 0 /f
echo Internet Explorer 其他程序从当前窗口的新选项卡打开链接
reg add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "ShortcutBehavior" /t REG_DWORD /d 1 /f
echo Internet Explorer 将同时下载数目调整到 10
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPerServer" /t REG_DWORD /d 10 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPer1_0Server" /t REG_DWORD /d 10 /f
echo 启用表单的自动完成功能
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use FormSuggest" /d "yes" /f
echo 设置IE主页 Start Page
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "https://www.baidu.com/?tn=simple" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Page" /d "https://www.baidu.com/" /f
echo 设置IE启动浏览器时打开的主页
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Start Page" /d "about:blank" /f
echo 设置IE默认主页 Default_Page_URL
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Default_Page_URL" /d "about:blank" /f
echo 设置默认搜索
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Default_Search_URL" /d "https://www.baidu.com/s?tn=baiduhome&wd=%s" /f
echo 设置默认搜索页面
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Search Page" /d "https://www.baidu.com/" /f
echo IE设置默认搜索引擎为百度
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes" /v "DefaultScope" /d "{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /f
echo IE默认搜索引擎参数调整
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "DisplayName" /d "百度" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "URL" /d "https://www.baidu.com/s?tn=baiduhome&wd={searchTerms}" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "SuggestionsURL_JSON" /d "http://suggestion.baidu.com/su?wd={searchTerms}&action=opensearch&ie=utf-8" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "FaviconURLFallback" /d "http://www.baidu.com/favicon.ico" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "ShowSearchSuggestions" /t REG_DWORD /d 1 /f
echo IE搜索引擎调序
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\{64AF4D11-6492-4C25-B014-B6C6CEE3B0C5}" /v "SortIndex" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\jd" /v "SortIndex" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\taobao" /v "SortIndex" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\sogou" /v "SortIndex" /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\SearchScopes\so" /v "SortIndex" /t REG_DWORD /d 5 /f
echo IE删除其他搜索引擎
reg delete "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes" /f >nul 2>nul
echo IE添加其他搜索引擎
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "DisplayName" /d "京东" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "URL" /d "https://search.jd.com/Search?keyword={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\jd" /v "FaviconURLFallback" /d "https://www.jd.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "DisplayName" /d "淘宝" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "URL" /d "https://s.taobao.com/search?q={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\taobao" /v "FaviconURLFallback" /d "https://www.taobao.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "DisplayName" /d "微信" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "URL" /d "http://weixin.sogou.com/weixin?type=2&ie=utf8&query={searchTerms}" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\sogou" /v "FaviconURLFallback" /d "https://weixin.sogou.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "DisplayName" /d "360" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "URL" /d "http://www.so.com/s?q={searchTerms}&ie=utf-8" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "SuggestionsURL_JSON" /d "http://sug.so.360.cn/suggest?word={searchTerms}&encodein=utf-8&encodeout=utf-8&outfmt=json" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "FaviconURL" /d "http://www.so.com/favicon.ico" /f
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\so" /v "ShowSearchSuggestions" /t REG_DWORD /d 1 /f
echo 启用“ActiveX控件”“JAVE小程序脚本”“活动脚本”等
rem https://blog.csdn.net/wangqiulin123456/article/details/17068649
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1001" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1004" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1200" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1201" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1208" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "120B" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1400" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1402" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1405" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1406" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1607" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "2201" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "2300" /t REG_DWORD /d 0 /f
echo 启用混合内容
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1609" /t REG_DWORD /d 0 /f
echo 关闭打开 局域网 文件的“安全警告”（Internet选项：加载应用程序和不安全文件时不提示）
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t REG_DWORD /d 0 /f
echo 正在添加 受信任站点（本地局域网）
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /d "10.*.*.*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range2" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range2" /v ":Range" /d "192.168.*.*" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range3" /v "file" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range3" /v ":Range" /d "169.254.*.*" /f
echo 关闭IE的安全设置检查功能
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /v "DisableSecuritySettingsCheck" /t REG_DWORD /d 1 /f
echo Internet Explorer 不保存附件的区域信息（文件锁定解锁）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d 1 /f
echo 关闭IE的Smartscreen筛选器
reg add "HKCU\Software\Microsoft\Internet Explorer\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 0 /f
echo 更改IE默认下载目录
reg delete "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Default Download Directory" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Default Download Directory" /d "D:\迅雷下载" /t REG_SZ /f
echo 127.0.0.1 ieonline.microsoft.com
SET NEWLINE=^& echo.
attrib -r %WINDIR%\system32\drivers\etc\hosts
FIND /C /I "geo2.adobe.com" %WINDIR%\system32\drivers\etc\hosts >nul
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 geo2.adobe.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "get3.adobe.com" %WINDIR%\system32\drivers\etc\hosts >nul
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 get3.adobe.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "ieonline.microsoft.com" %WINDIR%\system32\drivers\etc\hosts >nul
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^127.0.0.1 ieonline.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
attrib +r %WINDIR%\system32\drivers\etc\hosts
ipconfig /flushdns >nul
goto :eof

:LRCfile
echo 添加LRC歌词格式识别
reg add "HKCR\.lrc" /ve /d "lrcfile" /f
reg add "HKCR\.lrc" /v "PerceivedType" /d "text" /f
reg add "HKCR\lrcfile" /ve /d "lrc 歌词" /f
reg add "HKCR\lrcfile\DefaultIcon" /ve /d "imageres.dll,17" /f
reg add "HKCR\lrcfile\shell" /f
reg add "HKCR\lrcfile\shell\open" /f
reg add "HKCR\lrcfile\shell\open\command" /ve /d "NOTEPAD.EXE %%1" /f
goto :eof

:MacTime
echo 解决和Mac系统时间不同步的问题
Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1
goto :eof

:MicrosoftEdge
echo 阻止Microsoft Edge“首次运行”欢迎页面
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge" /v "PreventFirstRunPage" /t REG_DWORD /d 0 /f
echo 关闭Adobe Flash即点即用
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Security" /v "FlashClickToRunMode" /t REG_DWORD /d 0 /f
echo 使用Microsoft兼容性列表
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\BrowserEmulation" /v "MSCompatibilityMode" /t REG_DWORD /d 1 /f
echo 不再显示将EDGE设为默认浏览器的提示
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "DisallowDefaultBrowserPrompt" /t REG_DWORD /d 1 /f
echo 关闭Edge浏览器时提示“要关闭所有标签页吗？”
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" /v "AskToCloseAllTabs" /t REG_DWORD /d 0 /f
echo 在上下文菜单中显示“查看源”（文件）和“检查元素”
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\F12" /v "ShowPageContextMenuEntryPoints" /t REG_DWORD /d 1 /f
echo 关闭 MicrosoftEdge SmartScreen
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 0 /f
echo 禁止在新账户中创建Microsoft Edge快捷方式
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "DisableEdgeDesktopShortcutCreation" /t REG_DWORD /d 1 /f
echo 设置 Internet Explorer和 Microsoft edge收藏夹同步（系统默认不同步,必需登陆微软帐号才能IE与EDGE同步）
rem %localappdata%/Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\MicrosoftEdge\User\Default\Favorites
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "SyncFavoritesBetweenIEAndMicrosoftEdge" /t REG_DWORD /d "1" /f
goto :eof

:NetFX35
OptionalFeatures.exe
goto :eof

:NetReset
echo 重置网络连接
netsh advfirewall reset
netsh int ip reset
netsh winhttp reset proxy
netsh winsock reset
ipconfig /flushdns
echo 网络参数优化
echo 禁用 Receive Window Auto-Tuning Level（接收窗口自动调节级别）
rem 复    原 netsh int tcp set global autotuninglevel=normal
rem 查看状态 netsh interface tcp show global
netsh int tcp set global autotuninglevel=disabled
goto :eof

:NetShare
echo 解决在局域网内可以看到对方，但不能访问，找不到网络路径的问题。容许guest账户访问。
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d 1 /f
goto :eof

:Notepad
echo 记事本始终显示状态栏
reg add "HKCU\Software\Microsoft\NotePad" /v "StatusBar" /t REG_DWORD /d 1 /f
echo 记事本启用自动换行
reg add "HKCU\Software\Microsoft\NotePad" /v "fwrap" /t REG_DWORD /d 1 /f
echo 添加右键：文件：用记事本打开
rem （97）imageres.dll,289
reg add "HKCR\*\shell\Noteped" /ve /d "用记事本打开" /f
reg add "HKCR\*\shell\Noteped" /v "icon" /d "SHELL32.dll,70" /f
reg add "HKCR\*\shell\Noteped\command" /ve /d "Notepad.exe %%1" /f
goto :eof

:Notepad2
echo 复制Notepad2到系统
copy /y "Notepad2.exe" "%SystemRoot%" >nul 2>nul
echo 将Notepad劫持为Notepad2
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /f >nul 2>nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /d "\"C:\Windows\Notepad2.exe\" /z" /f >nul 2>nul
goto :eof

:OneDrive
echo 卸载OneDrive
rem https://go.microsoft.com/fwlink/?linkid=844652
rem 结束OneDrive进程
taskkill /f /im OneDrive.exe
rem 结束explorer进程，如不结束倒数第4、5、6行这3个文件夹是删不掉的
taskkill /f /im explorer.exe
rem 查看系统构架 卸载 32位/64位 OneDrive
if exist %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe (%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall) else (%SYSTEMROOT%\System32\OneDriveSetup.exe /uninstall)
rem 删除本地文件
rd /s /q "%UserProfile%\OneDrive" > NUL 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" > NUL 2>&1
rd /s /q "%ProgramData%\Microsoft OneDrive" > NUL 2>&1
rd /s /q "C:\OneDriveTemp" > NUL 2>&1
rem 删除注册表项，作用是从侧边栏移除OneDrive图标
reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
reg delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
reg delete "HKEY_USERS\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Run" /f > NUL 2>&1
rem 重启explorer
start explorer
goto :eof

:PhotoViewer
echo 启用 Windows 照片查看器
reg add "HKCU\Software\Classes\.bmp" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.gif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.ico" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.jpe" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.jpeg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.jpg" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.png" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.tga" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.tif" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKCU\Software\Classes\.tiff" /ve /d "PhotoViewer.FileAssoc.Tiff" /f
goto :eof

:Powercfg
echo 关闭休眠
powercfg -h off
echo 启用电源计划“高性能”
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
rem echo 开启卓越电源模式
rem powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo 启用电源计划“卓越性能”
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
echo 设置屏幕自动关闭时间为：5分钟
powercfg -x -monitor-timeout-ac 5
goto :eof

:RightMenuAdd
echo 添加：文件：注册(销)DLL/OCX文件
reg add "HKCR\dllfile\shell\注册 DLL\Command" /ve /d "Regsvr32 \\\"%%1\\\"" /f
reg add "HKCR\dllfile\shell\注销 DLL\Command" /ve /d "Regsvr32 /u \\\"%%1\\\"" /f
reg add "HKCR\ocxfile\shell\注册 OCX\Command" /ve /d "Regsvr32 \\\"%%1\\\"" /f
reg add "HKCR\ocxfile\shell\注销 OCX\Command" /ve /d "Regsvr32 /u \\\"%%1\\\"" /f
echo 添加：新建：批处理：bat
reg add "HKCR\.bat" /ve /d "batfile" /f
reg add "HKCR\.bat\PersistentHandler" /ve /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
reg add "HKCR\.bat\ShellNew" /v "NullFile" /d "" /f
goto :eof

:RightMenuDel
echo 清理：文件：新建
rem .BMP文件
reg delete "HKCR\.bmp\ShellNew" /f > NUL 2>&1
rem .联系人 
reg delete "HKCR\.contact\ShellNew" /f > NUL 2>&1
rem .RTF文件
reg delete "HKCR\.rtf\ShellNew" /f > NUL 2>&1
rem .rar文件
reg delete "HKLM\SOFTWARE\Classes\.rar\ShellNew" /f > NUL 2>&1
rem .zip文件
reg delete "HKLM\SOFTWARE\Classes\.zip\ShellNew" /f > NUL 2>&1
echo 清理：右键：发送到
rem 压缩(zipped)文件夹
del /f "%AppData%\Microsoft\Windows\SendTo\Compressed (zipped) Folder.ZFSendToTarget" > NUL 2>&1
rem 传真收件人
del /f "%AppData%\Microsoft\Windows\SendTo\Fax Recipient.lnk" > NUL 2>&1
rem 邮件收件人
del /f "%AppData%\Microsoft\Windows\SendTo\Mail Recipient.MAPIMail" > NUL 2>&1
rem 文档
del /f "%AppData%\Microsoft\Windows\SendTo\文档.mydocs" > NUL 2>&1
echo 清理：回收站右键：固定到开始屏幕
reg delete "HKLM\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
echo 清理：文件：兼容性疑难解答
reg delete "HKCR\Msi.Package\shellex\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\Compatibility" /f > NUL 2>&1
echo 清理：文件：共享
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f > NUL 2>&1
echo 清理：文件：还原以前的版本
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f > NUL 2>&1
echo 清理：磁盘文件夹：“固定到快速访问”
reg delete "HKCR\Folder\shell\pintohome" /f > NUL 2>&1
echo 清理：磁盘文件夹：“启用Bitlocker”右键菜单
reg delete "HKCR\Drive\shell\encrypt-bde" /f > NUL 2>&1
reg delete "HKCR\Drive\shell\encrypt-bde-elev" /f > NUL 2>&1
echo 清理：磁盘文件夹：“授予访问权限”（需重启）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}" /d "" /f > NUL 2>&1
echo 清理：文件夹：使用 VLC media player 播放
reg delete "HKCR\Directory\shell\AddToPlaylistVLC" /f > NUL 2>&1
reg delete "HKCR\Directory\shell\PlayWithVLC" /f > NUL 2>&1
echo 清理：WinRAR 右键 右键相关
reg add "HKCU\Software\WinRAR\Setup\MenuItems" /v "EmailArc" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\WinRAR\Setup\MenuItems" /v "EmailOpt" /t REG_DWORD /d 0 /f
echo 清理：图片/音乐右键菜单中的“Windows Media Player”选项
reg delete "HKCR\SystemFileAssociations\audio\shell" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Audio\shell" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Image\shell" /f > NUL 2>&1
echo 清理：文件：图片：向左、向右旋转
reg delete "HKCR\SystemFileAssociations\.bmp\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.gif\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.ico\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpeg\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.png\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.psd\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tiff\ShellEx\ContextMenuHandlers\ShellImagePreview" /f > NUL 2>&1
echo 清理：文件：图像、音频、视频及其他格式右键：播放到设备
reg delete "HKCR\SystemFileAssociations\image\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\audio\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\video\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.mkv\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.mp4\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.m4v\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Audio\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Image\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\Directory.Video\shellex\ContextMenuHandlers\PlayTo" /f > NUL 2>&1
echo 清理：文件：图片：使用画图3D进行编辑
reg delete "HKCR\SystemFileAssociations\.bmp\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.png\Shell\3D Edit" /f > NUL 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\Shell\3D Edit" /f > NUL 2>&1
echo 隐藏：图片右键：编辑 (按Shift显示)
reg add "HKCR\SystemFileAssociations\image\shell\edit" /v "Extended" /d "" /f
echo 隐藏：图片右键：设置为桌面背景 (按Shift显示)
reg add "HKCR\SystemFileAssociations\.jpg\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.png\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.bmp\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.tif\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
reg add "HKCR\SystemFileAssociations\.gif\Shell\setdesktopwallpaper" /v "Extended" /d "" /f
echo 隐藏：部分文件格式的右键：打印 (按Shift显示)
reg add "HKCR\SystemFileAssociations\image\shell\print" /v "Extended" /d "" /f
reg add "HKCR\batfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\cmdfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\regfile\shell\print" /v "Extended" /d "" /f
reg add "HKCR\txtfile\shell\print" /v "Extended" /d "" /f
echo 清理：opendlg
reg delete "HKCR\Unknown\shell\opendlg" /f > NUL 2>&1
reg delete "HKCR\Unknown\shell\opendlg\command" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\Folder\shell\pintostartscreen" /f > NUL 2>&1
reg delete "HKLM\SOFTWARE\Classes\Folder\shell\pintostartscreen\command" /f > NUL 2>&1
echo 清理：显卡项
rem reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\ACE" /f > NUL 2>&1
rem reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\NvCplDesktopContext" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxDTCM" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxOSP" /f > NUL 2>&1
reg delete "HKCR\Directory\Background\ShellEx\ContextMenuHandlers\igfxcui" /f > NUL 2>&1
echo 清理：Dell Display Manager
reg delete "HKCR\DesktopBackground\Shell\DDM" /f > NUL 2>&1
echo 清理：上传到WPS文档
reg delete "HKCR\*\shellex\ContextMenuHandlers\qingshellext" /f > NUL 2>&1
echo 清理：上传到百度网盘
reg delete "HKCR\*\shellex\ContextMenuHandlers\YunShellExt" /f > NUL 2>&1
goto :eof

:RightMenuShift
echo 添加:显示/隐藏文件 (按Shift显示)
>"%windir%\SuperHidden.vbs" echo Dim WSHShell
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = WScript.CreateObject("WScript.Shell")
>>"%windir%\SuperHidden.vbs" echo sTitle1 = "SSH=0"
>>"%windir%\SuperHidden.vbs" echo sTitle2 = "SSH=1"
>>"%windir%\SuperHidden.vbs" echo if WSHShell.RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden") = 1 then
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "2", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}"
>>"%windir%\SuperHidden.vbs" echo else
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}"
>>"%windir%\SuperHidden.vbs" echo end if
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = Nothing
>>"%windir%\SuperHidden.vbs" echo WScript.Quit(0)
reg add "HKCR\Directory\Background\shell\0SuperHidden" /ve /d "显示/隐藏文件"(H)"" /f
reg add "HKCR\Directory\Background\shell\0SuperHidden" /v "Extended" /d "" /f
reg add "HKCR\Directory\Background\shell\0SuperHidden" /v "icon" /d "shell32.dll,4" /f
reg add "HKCR\Directory\Background\shell\0SuperHidden\Command" /ve /d "WScript.exe C:\windows\SuperHidden.vbs" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 2 /f
echo 防止出现“解决没有在该机执行windows脚本宿主的权限。请与系统管理员联系。”的问题
regsvr32 /s scrrun.dll
reg add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d 1 /f
echo 添加:管理员取得所有权(获取TrustedInstaller权限) (按Shift显示)
reg add "HKCR\*\shell\runas" /ve /d "管理员取得所有权" /f
reg add "HKCR\*\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\*\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\*\shell\runas" /v "Extended" /d "" /f
reg add "HKCR\*\shell\runas" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\*\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\Directory\shell\runas" /ve /d "管理员取得所有权" /f
reg add "HKCR\Directory\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "Extended" /d "" /f
reg add "HKCR\Directory\shell\runas" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\Directory\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
reg add "HKCR\exefile\shell\runas2" /ve /d "管理员取得所有权" /f
reg add "HKCR\exefile\shell\runas2" /v "HasLUAShield" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "Extended" /d "" /f
reg add "HKCR\exefile\shell\runas2" /v "Icon" /d "imageres.dll,1" /f
reg add "HKCR\exefile\shell\runas2\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\exefile\shell\runas2\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
echo 添加：文件夹选项 (按Shift显示)
reg add "HKCR\Directory\Background\shell\文件夹选项" /ve /d "文件夹选项" /f
reg add "HKCR\Directory\Background\shell\文件夹选项" /v "Extended" /d "" /f
reg add "HKCR\Directory\Background\shell\文件夹选项" /v "icon" /d "SHELL32.dll,4" /f
reg add "HKCR\Directory\Background\shell\文件夹选项\command" /ve /d "rundll32.exe shell32.dll,Options_RunDLL 7" /f
echo 添加：文件夹：CMD快速通道 (按Shift显示)
reg add "HKCR\folder\shell\cmd" /ve /d "在此处打开命令提示符" /f
reg add "HKCR\folder\shell\cmd" /v "icon" /d "shell32.dll,71" /f
reg add "HKCR\folder\shell\cmd" /v "Extended" /d "" /f
reg add "HKCR\folder\shell\cmd\command" /ve /d "cmd.exe /s /k pushd \"%%V\"" /f
echo 添加：文件夹：复制文件夹路径 (按Shift显示)
reg add "HKCR\Directory\shell\copypath" /ve /d "复制文件夹路径" /f
reg add "HKCR\Directory\shell\copypath" /v "Extended" /d "" /f
reg add "HKCR\Directory\shell\copypath" /v "icon" /d "SHELL32.dll,4" /f
reg add "HKCR\Directory\shell\copypath\command" /ve /d "mshta vbscript:clipboarddata.setdata"(\"text\",\"%%1\")""(close)"" /f
echo 添加：文件：复制文件路径 (按Shift显示)
reg add "HKCR\*\shell\copypath" /ve /d "复制文件路径" /f
reg add "HKCR\*\shell\copypath" /v "Extended" /d "" /f
reg add "HKCR\*\shell\copypath" /v "icon" /d "SHELL32.dll,4" /f
reg add "HKCR\*\shell\copypath\command" /ve /d "mshta vbscript:clipboarddata.setdata"(\"text\",\"%%1\")""(close)"" /f
goto :eof

:RightMenuSysTools
echo 添加系统工具程序组
reg delete "HKCR\DesktopBackground\Shell\SysTools" /f > NUL 2>&1
reg add "HKCR\DesktopBackground\Shell\SysTools" /v "SubCommands" /d "" /f
reg add "HKCR\DesktopBackground\Shell\SysTools" /v "Icon" /d "SHELL32.dll,76" /f
reg add "HKCR\DesktopBackground\Shell\SysTools" /v "MUIVerb" /d "系统工具" /f
reg add "HKCR\DesktopBackground\Shell\SysTools" /v "Position" /d "Bottom" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\00SnippingTool" /ve /d "截图工具" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\00SnippingTool" /v "icon" /d "SnippingTool.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\00SnippingTool\command" /ve /d "SnippingTool.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\01Paint" /ve /d "画图" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\01Paint" /v "icon" /d "mspaint.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\01Paint\command" /ve /d "mspaint.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\02Calculator" /ve /d "计算器" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\02Calculator" /v "icon" /d "calc.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\02Calculator\command" /ve /d "calc.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\1Devmgmt" /ve /d "设备管理器" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\1Devmgmt" /v "icon" /d "DevicePairingWizard.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\1Devmgmt\command" /ve /d "mmc.exe devmgmt.msc" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\2Appwiz" /ve /d "添加或删除程序" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\2Appwiz" /v "icon" /d "wusa.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\2Appwiz\command" /ve /d "control appwiz.cpl" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\3ComputerDefaults" /ve /d "默认应用" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\3ComputerDefaults" /v "icon" /d "ComputerDefaults.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\3ComputerDefaults\command" /ve /d "ComputerDefaults.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\4CompMgmt" /ve /d "管理" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\4CompMgmt" /v "icon" /d "CompMgmtLauncher.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\4CompMgmt\command" /ve /d "CompMgmtLauncher.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\4ControlPanel" /ve /d "控制面板" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\4ControlPanel" /v "icon" /d "shell32.dll,21" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\4ControlPanel\command" /ve /d "rundll32.exe shell32.dll,Control_RunDLL" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\5Gpedit" /ve /d "组策略" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\5Gpedit" /v "icon" /d "SecEdit.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\5Gpedit\command" /ve /d "mmc.exe gpedit.msc" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\6Secpol" /ve /d "本地安全策略" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\6Secpol" /v "icon" /d "wlrmdr.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\6Secpol\command" /ve /d "mmc.exe secpol.msc" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\7Regedit" /ve /d "注册表" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\7Regedit" /v "icon" /d "Regedit.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\7Regedit\command" /ve /d "Regedit.exe" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\90Shutdown" /ve /d "十秒关机" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\90Shutdown" /v "icon" /d "shell32.dll,215" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\90Shutdown\command" /ve /d "Shutdown -s -hybrid -f -t 10" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\91Restart" /ve /d "立即重启" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\91Restart" /v "icon" /d "shell32.dll,112" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\91Restart\command" /ve /d "Shutdown -r -f -t 0" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\92ShutdownOff" /ve /d "取消关机" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\92ShutdownOff" /v "icon" /d "shell32.dll,215" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\92ShutdownOff\command" /ve /d "Shutdown -a" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\93RestartExplorer" /ve /d "重启资源管理器" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\93RestartExplorer" /v "icon" /d "shell32.dll,238" /f
reg add "HKCR\DesktopBackground\Shell\SysTools\Shell\93RestartExplorer\Command" /ve /d "tskill explorer" /f
echo 修复右键无新建的问题
reg add "HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\New" /ve /d "{D969A300-E7FF-11d0-A93B-00A0C90F2719}" /t REG_SZ /f
goto :eof

:Service
rem 服务调整部分：Win默认禁用的服务：AppVClient NetTcpPortSharing ssh-agent RemoteRegistry RemoteAccess shpamsvc tzautoupdate UevAgentService
rem 禁用使用情况信息的收集和传输
echo Connected User Experiences and Telemetry
sc config DiagTrack start=disabled
echo Data Sharing Service
sc config DsSvc start=disabled
echo Diagnostic Execution Service
sc config diagsvc start=disabled
echo 禁用诊断服务 Diagnostic Policy Service
sc config DPS start=disabled
echo Diagnostic Service Host
sc config WdiServiceHost start=disabled
echo Diagnostic System Host
sc config WdiSystemHost start=disabled
echo dmwappushsvc
sc config dmwappushservice start=disabled
echo Microsoft (R) 诊断中心标准收集器服务
sc config diagnosticshub.standardcollector.service start=disabled
echo "Performance Logs & Alerts"
sc config pla start=disabled
echo Problem Reports and Solutions Control Panel Support
sc config wercplsupport start=disabled

echo 禁用远程修改注册表
sc config RemoteRegistry start=disabled
echo 禁用程序兼容性助手 Program Compatibility Assistant Service
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /d 1 /t REG_DWORD /f >nul 2>nul
sc config PcaSvc start=disabled

echo 禁用 Hyper-V
rem To disable: 
bcdedit /set hypervisorlaunchtype off
rem To enable: bcdedit /set hypervisorlaunchtype auto
sc config HvHost start=disabled
sc config vmickvpexchange start=disabled
sc config vmicguestinterface start=disabled
sc config vmicshutdown start=disabled
sc config vmicheartbeat start=disabled
sc config vmicvmsession start=disabled
sc config vmictimesync start=disabled
sc config vmicvss start=disabled
sc config vmicrdv start=disabled

echo Xbox Accessory Management Service
sc config XboxGipSvc start=disabled
echo Xbox Live 身份验证管理器
sc config XblAuthManager start=disabled
echo Xbox Live 网络服务
sc config XboxNetApiSvc start=disabled
echo Xbox Live 游戏保存
sc config XblGameSave start=disabled
echo 禁用 XBOX GameDVR
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f > NUL 2>&1

echo Fax
sc config Fax start=disabled
echo Distributed Link Tracking Client
sc config TrkWks start=disabled
echo Downloaded Maps Manager
sc config MapsBroker start=disabled
echo Geolocation Service
sc config lfsvc start=disabled
echo Phone Service
sc config PhoneSvc start=disabled

echo Remote Registry(远程修改注册表)
sc config RemoteRegistry start=disabled
echo Superfetch
sc config SysMain start=disabled
echo Windows Media Player Network Sharing Service
sc config WMPNetworkSvc start=disabled
echo Windows Search
taskkill /f /im SearchUI.exe > NUL 2>&1
sc config WSearch start=disabled
echo Windows 推送通知系统服务
sc config WpnService start=disabled
echo 零售演示服务
sc config RetailDemo start=disabled

echo 国内服务
sc config QQMusicService start=disabled > NUL 2>&1
sc config QiyiService start=disabled > NUL 2>&1
sc config wpscloudsvr start=disabled > NUL 2>&1
goto :eof

:StartUp
echo 清理启动项
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp\*.lnk" 1>nul 2>nul
del /f /q "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\*.lnk" 1>nul 2>nul
echo 清空默认启动项
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f
taskmgr
goto :eof

:SystemRestore
echo 关闭系统保护并删除还原点
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR" /d 1 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /d 0 /t REG_DWORD /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer" /v "LimitSystemRestoreCheckpointing" /d 1 /t REG_DWORD /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f > NUL 2>&1
rem SystemPropertiesProtection.exe
goto :eof

:Taskbar
echo 打开文件资源管理器时 打开为：我的电脑
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
echo 隐藏任务栏中的Cortana
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
echo 隐藏任务栏上的人脉
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
rem echo 隐藏任务栏右下角操作中心图标：关闭右侧通知中心栏
rem reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f
echo 任务栏时间精确到秒
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d 1 /f
echo 当任务栏被占满时（合并任务栏按钮）：从不合并
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d 2 /f
echo 锁定任务栏
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarSizeMove" /t REG_DWORD /d 0 /f
echo 清理 系统托盘记忆的图标
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams > NUL 2>&1
echo y|reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream > NUL 2>&1
goto :eof

:Taskschd
rem 任务计划程序调整 %windir%\system32\taskschd.msc /s start taskschd.msc /s
echo Microsoft 客户体验改善计划
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 64 Critical"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\.NET Framework\.NET Framework NGEN v4.0.30319 Critical"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Application Experience\StartupAppTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Autochk\Proxy"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Diagnosis\Scheduled\RecommendedTroubleshootingScanner"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Diagnosis\Scheduled"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\DiskFootprint\Diagnostics"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Feedback\Siuf\DmClient"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Location\Notifications"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Location\WindowsActionDialog"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maintenance\WinSAT"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maps\MapsToastTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Maps\MapsUpdateTask"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\RetailDemo\CleanupOfflineContent"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\WDI\ResolutionHost"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
echo Windows Defender
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
echo 驱动器优化和碎片整理
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"
echo 自动磁盘清理
SCHTASKS /Change /Disable /TN "\Microsoft\Windows\DiskCleanup\SilentCleanup"
echo XblGameSaveTask
SCHTASKS /Change /Disable /TN "\Microsoft\XblGameSave\XblGameSaveTask"
echo Adobe
SCHTASKS /Change /DISABLE /TN "\AdobeAAMUpdater-1.0-%computername%-%username%" > NUL 2>&1
echo ASUS
SCHTASKS /Change /DISABLE /TN "\ASUS\Ez Update" > NUL 2>&1
echo GoogleUpdate
SCHTASKS /Change /DISABLE /TN "\GoogleUpdateTaskMachineUA" > NUL 2>&1
SCHTASKS /Change /DISABLE /TN "\GoogleUpdateTaskMachineCore" > NUL 2>&1
echo Office遥测代理的后台任务
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack"
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn"
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\Office 15 Subscription Heartbeat" > NUL 2>&1
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" > NUL 2>&1
SCHTASKS /Change /DISABLE /TN "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" > NUL 2>&1
goto :eof

:WMPlayer
echo Windows Media Player 不显示首次使用对话框
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "GroupPrivacyAcceptance" /t REG_DWORD /d 1 /f > NUL 2>&1
goto :eof

:WindowsApps
TITLE 卸载 Microsoft Store
::a.     移除了下列应用/服务：（保留：Desktop App Installer、Store Purchase App、钱包、应用商店、Xbox、Windows To Go）
echo 删除 3D查看器
PowerShell "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
echo 删除 地图
PowerShell "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"
echo 删除 电影和电视
PowerShell "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"
echo 删除 反馈中心
PowerShell "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
echo 删除 Groove音乐
PowerShell "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
echo 删除 画图3D
PowerShell "Get-AppxPackage *Microsoft.MSPaint* | Remove-AppxPackage"
echo 删除 混合现实门户
PowerShell "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
echo 删除 录音机
PowerShell "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
echo 删除 Microsoft Solitaire Collection
PowerShell "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
echo 删除 你的手机
PowerShell "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
echo 删除 Office Hub
PowerShell "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
echo 删除 OneNote
PowerShell "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"
echo 删除 日历和邮件
PowerShell "Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage"
echo 删除 SkypeApp
PowerShell "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"
echo 删除 Sticky Notes
PowerShell "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
echo 删除 使用技巧
PowerShell "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
echo 删除 天气
PowerShell "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
echo 删除 卸载Xbox游戏组件
PowerShell "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
PowerShell "Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage"
echo 删除 移动套餐
PowerShell "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"
echo 删除 卸载游戏录制工具栏
PowerShell "Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
PowerShell "get-appxpackage *Microsoft.XboxGamingOverlay* | remove-appxpackage"
echo 删除 照片
PowerShell "Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage"
rem ::获取帮助
rem PowerShell "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
rem ::闹钟和时钟
rem PowerShell "Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage"
rem ::人脉
rem PowerShell "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
rem ::相机
rem PowerShell "Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage"
rem ::消息
rem PowerShell "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
goto :eof

:WindowsDefender
echo 删除安全中心开机启动
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>nul
SecurityHealthSystray
echo 禁用Windows Defender 安全中心服务
reg add "HKLM\SYSTEM\ControlSet001\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
echo 在未安装通过微软注册的杀软的情况下关闭Windows Security Center
reg add "HKLM\SOFTWARE\Microsoft\Security Center\Feature" /v "DisableAvCheck" /t REG_DWORD /d 1 /f
echo 关闭 Windows Defender 防病毒程序
taskkill /f /im MSASCuil.exe >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD /f
echo 允许反恶意软件服务始终保持运行状态
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d 0 /f
echo 关闭 Windows Defender SmartScreen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f
echo 禁用Windows Defender SmartScreen 应用安装控制
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d 0 /f
echo 关闭实时防护
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
echo 禁用行为监视
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f
echo 禁用扫描所有下载文件和附件
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f
echo 禁止监视文件和程序活动
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f
echo 禁止在打开实时保护时启动进程扫描
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f
echo 禁用恶意软件删除工具的Windows更新
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f
echo 清理：文件：使用Windows Defender扫描
reg delete "HKCR\Drive\ShellEx\ContextMenuHandlers\EPP" /f > NUL 2>&1
reg delete "HKCR\Directory\ShellEx\ContextMenuHandlers\EPP" /f > NUL 2>&1
reg delete "HKCR\*\ShellEx\ContextMenuHandlers\EPP" /f > NUL 2>&1
call :GpUpdate
goto :eof

:WindowsLog
echo 禁用错误报告(Windows Error Reporting Service)
sc config WerSvc start= disabled
echo 禁用WfpDiag.ETL日志
netsh wfp set options netevents = off
echo 禁用Dirty shutdown event日志
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 0 /f
echo 禁用系统日志
reg add "HKCU\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
echo 禁用账号登录日志报告
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "ReportBootOk" /d "0" /f
goto :eof

:WindowsUAC
echo 关闭用户账户控制（UAC）
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f
echo 解决文件拖拽无法打开的问题
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
echo 去除UAC小盾牌
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 77 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f
echo 关闭打开 本地 文件的“安全警告”
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "ModRiskFileTypes" /d ".7z;.cab;.bat;.chm;.cmd;.exe;.js;.msi;.rar;.reg;.vbs;.zip;.txt" /f
goto :eof

:WindowsUpdateClr
echo Windows更新清理
net stop wuauserv
del /s /q /f %windir%\SoftwareDistribution\Download\*.*
del /s /q /f %windir%\SoftwareDistribution\DataStore\*.*
net start wuauserv
start ms-settings:windowsupdate
goto :eof

:Wsreset
echo 清理应用商店缓存
wsreset
goto :eof

:SoftSN
echo CollageIt
rem http://www.collageitfree.com/download/CollageIt.exe
reg add "HKCU\Software\PearlMountain\CollageIt" /v "RegCode" /d "CLGIT-0252A-0D167-1578C-0AB4F" /f
echo Driver Magician
rem http://www.drivermagician.com/DriverMagician.exe
reg add "HKCU\Software\Driver Magician" /v "serialnumber" /d "6FL51dEf88-D88D2" /f
reg add "HKCU\Software\Driver Magician" /v "username" /d "Driver Magician" /f
echo EasyBoot
reg add "HKCU\Software\EasyBoot Systems\EasyBoot\3.0" /v "UserName" /d "中华人民共和国" /f
reg add "HKCU\Software\EasyBoot Systems\EasyBoot\3.0" /v "Registration" /d "771f3d7a0f2f6c481f73351609687f15" /f
echo EasyBoot-UltraISO
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "UserName" /d "王涛" /f
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /v "Registration" /d "69414b170e136f766a32471009176109" /f
echo gBurner
rem http://www.gburner.com/download.htm
reg add "HKCU\Software\gBurner" /v "USER" /t REG_BINARY /d "0007674275726e65723b74c6223b171dcc8490c50338d7262d" /f
echo PowerISO
rem http://www.poweriso.com/download.php
reg add "HKCU\Software\PowerISO" /v "USER" /t REG_BINARY /d "0008506f77657249534fe66a84c1ce846925c12fb7f5f28e2b0c" /f
echo Teleport Pro
rem http://www.tenmax.com/teleport/pro/download.htm  http://www.tenmax.com/Teleport_Pro_Installer.exe
reg add "HKCU\Software\Tennyson Maxwell\Teleport Pro\User" /v "Name" /d "Teleport Pro" /f
reg add "HKCU\Software\Tennyson Maxwell\Teleport Pro\User" /v "Registration" /t REG_DWORD /d 597602693 /f
echo TurboLaunch
rem http://www.savardsoftware.com/turbolaunch/
reg add "HKCU\Software\TurboLaunch" /v "RegistrationCode" /d "BHYQKB-DQJ5ZW-DD171G" /f
reg add "HKCU\Software\TurboLaunch" /v "RegistrationName" /d "TurboLaunch" /f
reg add "HKCU\Software\TurboLaunch" /v "ShowSplashScreen" /t REG_DWORD /d 0 /f
echo WPS2000
reg add "HKCU\Software\Kingsoft\WPS2000\Registration" /v "User" /d "WPS User" /f
reg add "HKCU\Software\Kingsoft\WPS2000\Registration" /v "Company" /d "WPS" /f
reg add "HKCU\Software\Kingsoft\WPS2000\Registration" /v "Serial" /d "KSW00-00000-00000" /f
echo 去WPS广告推荐弹窗
reg add "HKCU\Software\Kingsoft\Office\6.0\Common\updateinfo" /v "StateSvr" /d "-" /f
reg add "HKCU\Software\Kingsoft\Office\6.0\Common\updateinfo" /v "UpdateRecommend" /d "false" /f
reg add "HKCU\Software\Kingsoft\Office\6.0\plugins\minisiteex" /v "instncstrt" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Kingsoft\Office\6.0\plugins\minisiteex" /v "kbtrystatus" /d "close" /f
echo ZD Soft\Screen Recorder
rem http://www.zdsoft.com/download/SRSetup.exe
reg add "HKCU\Software\ZD Soft\Screen Recorder\7CCC341F9C9547828A0C2D346BDB4BD8" /v "Name" /d "Screen Recorder" /f
reg add "HKCU\Software\ZD Soft\Screen Recorder\7CCC341F9C9547828A0C2D346BDB4BD8" /v "Email" /d "screenrecorder@zdsoft.com" /f
reg add "HKCU\Software\ZD Soft\Screen Recorder\7CCC341F9C9547828A0C2D346BDB4BD8" /v "Key" /d "6C8J0-JNB6V-E5VEF-V02JX-BF6J0" /f
echo XnView
rem https://www.xnview.com/en/xnviewmp/#downloads
reg add "HKLM\SOFTWARE\WOW6432Node\XnView" /v "LicenseName" /d "XnView" /f
reg add "HKLM\SOFTWARE\WOW6432Node\XnView" /v "LicenseNumber" /d "1765133585" /f
goto :eof
