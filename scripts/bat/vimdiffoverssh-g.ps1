While ($true)
{
	$file = Read-Host "Enter the file name."
	$fullpath = "/data/home$file"
	$cmd = "vimdiff $fullpath scp://suralacore01@srn-stg-gameweb-1//$fullpath"
	Write-Host $cmd
}
$host.UI.RawUI.ReadKey()