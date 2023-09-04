#IfWinActive ahk_exe chrome.exe
F12::
Send !d
Sleep, 10
Send ^+i
return

^+i::
Send !d
Sleep, 10
Send ^+i
return
#If