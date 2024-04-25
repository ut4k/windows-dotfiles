^!d::
FormatTime, now,, yyyyMMdd
Clipboard = %now%
Send,^v
return

^!+d::
FormatTime, now,, yyyy/MM/dd
Clipboard = %now%
Send,^v
return