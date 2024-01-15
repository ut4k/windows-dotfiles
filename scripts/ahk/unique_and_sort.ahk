hasValue(haystack, needle) {
    if(!isObject(haystack))
        return false
    if(haystack.Length()==0)
        return false
    for k,v in haystack
        if(v==needle)
            return true
    return false
}

StrJoin(array, delimiter := "") {
   result := ""
   for index, element in array {
       result .= (index = 1 ? "" : delimiter) . element
   }
   return result
}

^!u::
    ; Get clipboard content
    Clipboard := ClipboardAll
    Clipboard := RegExReplace(Clipboard, "(\r\n?|\n)", "`r`n") ; Normalize line endings

    ; Split lines into an array
    lines := StrSplit(Clipboard, "`r`n")

    ; Remove duplicates
    uniqueLines := {}
    for index, line in lines {
        if (!hasValue(uniqueLines, line))
            uniqueLines.push(line)
    }
    ;for index, elm in uniqueLines {
    ;    MsgBox % "Element number " . index . " is " . elm
    ;}

    ; Join unique lines back into a string
    uniqueClipboard := StrJoin(uniqueLines, "`n")

    ; Sort the unique lines
    Sort, uniqueClipboard, , "`n"

    ; Set clipboard to the unique content
    Clipboard := uniqueClipboard

    ; Show message
    MsgBox, duplicated line removed

    ; Cleanup
    Clipboard := ClipboardAll
    Return

