^!j:: ; Ctrl+Alt+J
 shellobj := ComObjCreate("Scriptlet.TypeLib")
 shellexec := shellobj.GUID
 resultString := StrReplace(shellexec, "{", "")
 resultString := StrReplace(resultString, "}", "")
 clipboard := resultString
 MsgBox, % clipboard