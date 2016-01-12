copy/b hosts.txt+mobile.txt android.txt
rem dos2unix.exe -n android.txt hosts
"%~dp0lib\dos2unix.exe" -n android.txt hosts
del android.txt