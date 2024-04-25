^!x::
    Clipboard := ClipboardAll
    NewFilePath := Clipboard
    ; Construct the VimDiffCommand
    VimDiffCommand := "vimdiff /data/home" . NewFilePath . " scp://suralacore01@srn-stg-coreweb-1///data/home" . NewFilePath

    ; Copy the VimDiffCommand to the clipboard
    Clipboard := VimDiffCommand
    
    ; Display a tooltip indicating that the command has been converted
    ToolTip, converted to vimdiff command
    Sleep, 2000 ; Show tooltip
    ToolTip ; Clear the tooltip
    
    ; Return to exit the hotkey
    return
