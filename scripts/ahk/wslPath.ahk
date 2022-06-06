; Example:
;   C:\Program Files (x86)  -> "/mnt/c/Program Files (x86)"
;   /mnt/c/Users/user       -> C:\Users\user
;   \\wsl$\Ubuntu\home\user -> /home/user
;   /tmp                    -> \\wsl$\Ubuntu\tmp
!F19::
    distroName := "Ubuntu-20.04"
    tmpClip := Trim(Clipboard)
    
    if (RegExMatch(tmpClip, "^""(.+)""$", $)) {
        ; unwrap doublequote
        tmpClip := $1
    }
    
    if (RegExMatch(tmpClip, "^/")) {
        ; unescape single/backquote
        tmpClip := RegExReplace(tmpClip, "\\(?=[``'])", "")
    }
    
    if (RegExMatch(tmpClip, "^([a-zA-Z]):(.+)", $)) {
        ; Win -> WSL
        StringLower, letter, $1
        tmpClip := "/mnt/" . letter . RegExReplace($2, "\\", "/")
    } else if (RegExMatch(tmpClip, "^/mnt/([a-z])(.+)", $)) {
        ; WSL -> Win
        StringUpper, letter, $1
        tmpClip := letter . ":" . RegExReplace($2, "/", "\")
    } else if (RegExMatch(tmpClip, "^\\\\wsl\$\\[^\\]+\\?(.+)", $)) {
        ; UNC(WSL) -> WSL
        tmpClip := "/" . RegExReplace($1, "\\", "/")
    } else if (RegExMatch(tmpClip, "^(/.+)", $)) {
        ; WSL -> UNC(WSL)
        tmpClip := "\\wsl$\" . distroName . RegExReplace($1, "/", "\")
    }
    
    if (RegExMatch(tmpClip, "^/")) {
        ; escape single/backquote
        tmpClip := RegExReplace(tmpClip, "(?=[``'])", "\")
    }
    
    if (RegExMatch(tmpClip, " ")) {
        ; wrap doublequote
        tmpClip := """" . tmpClip . """"
    }
    
    Clipboard := tmpClip
return
