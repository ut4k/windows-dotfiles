; Define a hotkey for Alt+V
!v::
; 1. Popup input box for the path
InputBox, nvimPath, Open nvim-qt at, Open nvim-qt at:

; Check if the user clicked cancel or left the input box empty
if nvimPath = 
{
    MsgBox, No path provided. Exiting...
    return ; Exit the script
}

; 2. Change current working directory to the specified path
SetWorkingDir, %nvimPath%

; 3. Launch nvim-qt.exe
Run, nvim-qt.exe

return ; Return to the main script
