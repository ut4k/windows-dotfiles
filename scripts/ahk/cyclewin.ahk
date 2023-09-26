F3:: ; Move bottom window to top
F4:: ; Move top window to bottom
win := []
WinGet, wins, List
Loop, %wins% {
 WinGetTitle, ttitle, % winTitle := "ahk_id " wins%A_Index%
 WinGet, proc, ProcessName, %winTitle%
 WinGet, state, MinMax, %winTitle%
 SplitPath, proc,,,, proc
 WinGetClass, class, %winTitle%
 If (ttitle > "" && (ttitle != "Program Manager" || proc != "Explorer") && class != "#32770" && state != -1)
  If proc not in Rainmeter
   win.Push(wins%A_Index%)
}
If (A_ThisHotkey = "F4") {
 WinSet, Bottom,  , % "ahk_id " win.1
 WinActivate      , % "ahk_id " win.2
} Else {
 WinActivate, % "ahk_id " win[win.MaxIndex()]
}
Return