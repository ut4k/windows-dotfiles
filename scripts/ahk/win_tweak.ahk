; Win+Eを、クリップボードの内容を元にTablacus Explorerで開くコマンドに変更
; 環境変数 FILE_EXPLORER にTablacus Explorerのパスを設定しておく
#e::
    EnvGet, fileExplorer, FILE_EXPLORER
    
    tmpclip := clipboard
    if (InStr(tmpclip, "`r`n") != 0) {
        tmpArray := StrSplit(tmpclip, "`r`n")
    } else {
        tmpArray := StrSplit(tmpclip, "`n")
    }
    tmpArray := uniqueArray(tmpArray)
    
    openCount := 0
    loop, % tmpArray.Length() {
        filePath := Trim(tmpArray[A_Index])
        if (RegExMatch(filePath, "^""(.+)""$", $)) {
            filePath := $1
        }
        
        if (RegExMatch(filePath, "^file:(?:///)?(.+)", $)) {
            ; file://
            filePath := RegExReplace($1, "/", "\")
        } else if (RegExMatch(filePath, "^/")) {
            ; WSLパスの場合はWindowsパスに変換する
            filePath := ToggleFilePath(filePath)
        }
        
        fileAttr := FileExist(filePath)
        if (RegExMatch(fileAttr, "D")) {
            ; ディレクトリの場合はそのまま開く
            Run, "%fileExplorer%" "%filePath%"
            openCount++
        } else if (fileAttr) {
            ; ファイルの場合はフォーカスを当てた状態で開く
            select := "/select" . Chr(44)
            Run, "%fileExplorer%" %select%"%filePath%"
            openCount++
        } else {
            if (openCount = 0) {
                ; ファイルが存在しない場合はホームディレクトリを開く
                EnvGet, userProfile, USER_PROFILE
                Run, "%fileExplorer%" "%userProfile%"
            }
            exit
        }
    }
return

; WindowsとWLSのパスを相互変換
; Example:
;   C:\Users\user  -> /mnt/c/Users/user
;   /mnt/c/Users/user       -> C:\Users\user
;   \\wsl$\Ubuntu\home\user -> /home/user
;   /tmp                    -> \\wsl$\Ubuntu\tmp
ToggleFilePath(filePath)
{
    ; /mnt/[A-Z] 以外のWSLパスをUNCに変換する場合のディストリビューション名
    distroName := "Ubuntu"
    
    if (RegExMatch(filePath, "^/")) {
        ; unescape single/back quote
        filePath := RegExReplace(filePath, "\\(?=[``'])", "")
    }
    
    if (RegExMatch(filePath, "^([a-zA-Z]):(.+)", $)) {
        ; Win -> WSL
        StringLower, letter, $1
        filePath := "/mnt/" . letter . RegExReplace($2, "\\", "/")
    } else if (RegExMatch(filePath, "^/mnt/([a-z])(.+)", $)) {
        ; WSL -> Win
        StringUpper, letter, $1
        filePath := letter . ":" . RegExReplace($2, "/", "\")
    } else if (RegExMatch(filePath, "^\\\\wsl\$\\[^\\]+\\?(.+)", $)) {
        ; UNC(WSL) -> WSL
        filePath := "/" . RegExReplace($1, "\\", "/")
    } else if (RegExMatch(filePath, "^(/.+)", $)) {
        ; WSL -> UNC(WSL)
        filePath := "\\wsl$\" . distroName . RegExReplace($1, "/", "\")
    }
    
    if (RegExMatch(filePath, "^/")) {
        ; escape single/back quote
        filePath := RegExReplace(filePath, "(?=[``'])", "\")
    }
    
    return filePath
}

uniqueArray(nameArray)
{
    hash := {}
    for i, name in nameArray {
        hash[name] := null
    }
    
    trimmedArray := []
    for name, dummy in hash {
        trimmedArray.Insert(name)
    }
    
    return trimmedArray
}