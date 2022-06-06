@echo off
chcp 65001

:LOOP
	set /p w="word:"
	wsl -d Ubuntu trans -b :en+ind+km %w% ^| tr "\n" "\t" ^| sed 's/\t$//' | clip
goto :LOOP