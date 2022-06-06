@echo off

set /p file="target file?:"

set basepath=C:/workspace/surala

set cmd="C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:log /path:"%basepath%%file%"
echo %cmd%
%cmd%

pause