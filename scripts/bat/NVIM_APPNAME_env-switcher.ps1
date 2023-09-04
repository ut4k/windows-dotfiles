$newVal = Read-Host "Enter new NVIM_APPNAME value"

try {
    [System.Environment]::SetEnvironmentVariable("NVIM_APPNAME", $newVal, "User")
 
} catch {
    $ErrorMessage = $_.Exception_Message
    $ErrorMessage
    Write-Host "エラー: $error" -ForegroundColor Yellow
	$host.UI.RawUI.ReadKey()
	exit
}

$new = [System.Environment]::GetEnvironmentVariable("NVIM_APPNAME", "User")
Write-Host "NVIM_APPNAME is now: $new"
$host.UI.RawUI.ReadKey()