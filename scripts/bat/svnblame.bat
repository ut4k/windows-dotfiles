@echo off

set /p file="[SVN Blame] target file?:"

set basepath=C:/workspace/surala

set cmd="C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:blame /path:"%basepath%%file%"
echo %cmd%
%cmd%

pause