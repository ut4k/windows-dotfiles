;  IN clause
#f1::
		tmpclip := clipboard
    if (InStr(tmpclip, "IN(") != 0) {
        return
    }
    if (InStr(tmpclip, "`r`n") != 0) {
        tmpArray := StrSplit(tmpclip, "`r`n")
    } else {
        tmpArray := StrSplit(tmpclip, "`n")
    }
    
    clipString := ""
    exists := Object()
    loop, % tmpArray.Length() {
        entry := Trim(tmpArray[A_Index])
        if (!entry) {
            Continue
        }
        if (!exists[entry]) {
            exists[entry] := 1
            clipString .= "'" . entry . "',"
        }
    }
    if (clipString) {
        clipboard := " IN(" . SubStr(clipString, 1, -1) . ") "
    }
return