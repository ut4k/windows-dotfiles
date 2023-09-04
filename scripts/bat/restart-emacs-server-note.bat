@echo off
set server_file=note


cd "c:\org"

C:\app\emacs\bin\emacsclientw.exe -e "(save-buffers-kill-emacs)" --server-file=%server_file%
del %HOME%\.emacs.d\server\%server_file%
C:\app\emacs\bin\runemacs.exe --daemon=%server_file%
echo "Emacs Server has been started."
echo "Server: %server_file%"
pause