Add-Type -AssemblyName microsoft.VisualBasic
Add-Type -AssemblyName System.Windows.Forms


Start-Process -FilePath "C:\Program Files\PuTTY\pageant.exe" -ArgumentList "C:\Users\kimura.AZET\.ssh\suralacore01.ppk"
start-sleep -Milliseconds 1000

Add-Type -AssemblyName microsoft.VisualBasic
Add-Type -AssemblyName System.Windows.Forms

$SecurePassword = Get-Content "C:\Users\kimura.AZET\.ssh\suralacore01.pass" | ConvertTo-SecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
# $app = get-process | where {$_.mainwindowtitle -match "Pageant: Enter Passphrase"}
$app = get-process | where {$_.mainwindowtitle -match "Pageant: .*"}
$processID = 0
foreach ($a in $app) {
	if ($a.id -gt $processID) {
		$processID = $a.id
	}
}
start-sleep -Milliseconds 500
[Microsoft.VisualBasic.Interaction]::AppActivate($processID)
[System.Windows.Forms.SendKeys]::SendWait("$password{ENTER}")
Clear-Variable -Name "password"
pause