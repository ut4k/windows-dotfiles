; windows terminalがアクティブになったらIMEをONにする
; windows terminalはgoogle日本語入力を使用していると、勝手に「半角英数」に切り替えをしてしまう問題がある。
; このまま入力しようとするとまともにコマンドがうてない&ショートカットも効かない！
; これを回避するためにwt上では強制的にIMEをつかう。
;
; 事前設定
; 設定 > 時刻と言語 > 入力 > キーボードの詳細設定 > 入力言語のホットキー > IMEへ 左Alt+Shift+2
; →　 Send, !+2

#Persistent
SetTimer, CheckActiveWindow, 100
imeActive := false
return

CheckActiveWindow:
if WinActive("ahk_exe WindowsTerminal.exe")
{
 if (!imeActive) {
   ;Sleep, 500
   SwitchIME()
   imeActive := true
 }
} else {
 imeActive := false
}
return

SwitchIME() {
 Send, !+2
 ;Send, {LWin Down}{Space}{LWin Up}
}
