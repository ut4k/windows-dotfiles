# 管理者
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')){
    Start-Process -FilePath PowerShell.exe -ArgumentList "-NoLogo -ExecutionPolicy Bypass -File $($MyInvocation.MyCommand.Path)" -Verb RunAs
    Exit
}

# 参考:Qitta
# https://qiita.com/Yorcna/items/1390ba8f91b6d229b2c3

Enable-NetAdapterBinding -Name "イーサネット" -ComponentID ms_tcpip6
Get-NetAdapterBinding -Name "イーサネット" -ComponentID ms_tcpip6

echo "ipv6を有効化しました"

$host.UI.RawUI.ReadKey()
