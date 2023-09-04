I_Icon = C:\Users\kimura.AZET\scripts\ahk\img\vimmode_inactive.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%

VimPoweredScript=0 ; off by default

^i::
VimPoweredScript:=!VimPoweredScript ; toggle it
if (VimPoweredScript = 1)
{
	I_Icon = C:\Users\kimura.AZET\scripts\ahk\img\vimmode_active.ico
	IfExist, %I_Icon%
	Menu, Tray, Icon, %I_Icon%
;	Gui, Add, Picture, AltSubmit, C:\img\ahk\vimmode.png
;	Gui -Border +MaxSize266x38 -Caption +ToolWindow +AlwaysOnTop
;	Gui, Show, NoActivate
} Else {
	I_Icon = C:\Users\kimura.AZET\scripts\ahk\img\vimmode_inactive.ico
	IfExist, %I_Icon%
	Menu, Tray, Icon, %I_Icon%
;	Gui, Hide
}
Return

#If (VimPoweredScript = 1) ; as it uses #If you need AutoHotkey_L http://l.autohotkey.net/
k::up
j::down
l::right
h::left
u::home
e::end
; d::delete
; p::PgUp
; sc027::PgDn
#If