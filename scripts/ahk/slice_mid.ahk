; クリップボードにある文字列の先頭と末尾の文字を削除して入れ直す
; 例:
; 4123456781 -> 12345678

^!;::
    ; Get the current clipboard content
    Clipboard := ClipboardAll

    ; Remove newline characters from the clipboard content
    Clipboard := StrReplace(Clipboard, "`r`n", "")  ; Remove both carriage return (`r) and line feed (`n) characters

    ; Check if the clipboard has any content
    if (Clipboard != "") {
        ; Get the length of the clipboard content
        Len := StrLen(Clipboard)

        ; Check if the length is greater than 2 (to ensure at least two characters are present)
        if (Len > 2) {
            ; Remove the first and last characters
            NewClipboard := SubStr(Clipboard, 2, Len - 2)

            ; Set the modified content back to the clipboard
            Clipboard := NewClipboard

            ; Optionally, you can display a tooltip or perform other actions to notify the user
            ToolTip, Clipboard content modified: %NewClipboard%
            Sleep, 1000
            ToolTip
        }
    }
    return
