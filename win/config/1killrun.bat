:killrun
for /f "tokens=*" %%k in (killrun.txt) do taskkill /f /t /im %%k & REG DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /V %%k /f & reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%k" /v debugger /t reg_sz /d debugfile.exe /f
for /f "tokens=*" %%d in (allusrfile.txt) do echo y| cacls "%AllUsersProfile%\%%d" /c /t /p everyone:f >nul 2>nul & rd "%AllUsersProfile%\%%d" & echo .> "%AllUsersProfile%\%%d" & attrib +r +s +h "%AllUsersProfile%\%%d" & echo y| cacls "%AllUsersProfile%\%%d" /D everyone >nul 2>nul
for /f "tokens=*" %%a in (appdata.txt) do echo y| cacls "%AppData%\%%a" /c /t /p everyone:f >nul 2>nul &DEL /F /Q /A "%AppData%\%%a" & rd "%AppData%\%%a" /s /q & echo .> "%AppData%\%%a" & echo y| cacls "%AppData%\%%a" /D everyone >nul 2>nul
for /f "tokens=*" %%d in (appdatadir.txt) do echo y| cacls "%AppData%\%%d" /c /t /p everyone:f >nul 2>nul & rd "%AppData%\%%a" /s /q & DEL /F /Q /A "%AppData%\%%d" & Md "%AppData%\%%d" & attrib +r +s +h "%AppData%\%%d" & echo y| cacls "%AppData%\%%d" /D everyone >nul 2>nul
for /f "tokens=*" %%p in (pgdir.txt) do md "%ProgramFiles(x86)%\%%p" & md "%ProgramFiles%\%%p"
for /f "tokens=*" %%p in (pgfiles.txt) do del /f /s /q "%ProgramFiles%\%%p\*.*" & rd "%ProgramFiles%\%%p" /s /q & echo .> "%ProgramFiles%\%%p" & del /f /s /q "%ProgramFiles(x86)%\%%p\*.*" & rd "%ProgramFiles(x86)%\%%p" /s /q & echo .> "%ProgramFiles(x86)%\%%p"
for /f "tokens=*" %%d in (prgdata.txt) do echo y| cacls "%ProgramData%\%%d" /c /t /p everyone:f >nul 2>nul & DEL /F /Q /A "%ProgramData%\%%d" & Md "%ProgramData%\%%d" & attrib +r +s +h "%ProgramData%\%%d" & echo y| cacls "%ProgramData%\%%d" /D everyone >nul 2>nul
for /f "tokens=*" %%d in (tmpvirus.txt) do echo y| cacls "%temp%\%%d" /c /t /p everyone:f >nul 2>nul & DEL /F /Q /A "%temp%\%%d" & Md "%temp%\%%d" & attrib +r +s +h "%temp%\%%d" & echo y| cacls "%temp%\%%d" /D everyone >nul 2>nul
for /f "tokens=*" %%d in (winvirus.txt) do echo y| cacls "%windir%\%%d" /c /t /p everyone:f >nul 2>nul & DEL /F /Q /A "%windir%\%%d" & Md "%windir%\%%d" & attrib +r +s +h "%windir%\%%d" & echo y| cacls "%windir%\%%d" /D everyone >nul 2>nul
for /f "tokens=*" %%d in (lnk.txt) do DEL /F /Q /A "%systemdrive%\Users\Public\Desktop\%%d" >nul 2>nul
goto :eof

