While ($true)
{
	$file = Read-Host "Enter the file name."
	$fullpath = "/data/home$file"
	$entrypath = $fullpath.Replace("/data/home/ent/", "/data/home/")
	$cmd = "vimdiff $fullpath scp://suralacore01@srn-stg-coreweb-1//$entrypath"
	Write-Host $cmd
}
$host.UI.RawUI.ReadKey()