param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$MarkdownFile
)

$homeDir = [Environment]::GetFolderPath('UserProfile')
$cssPath1 = Join-Path $homeDir "scripts\css\markdown-css-themes-gh-pages\markdown7.css"
$cssPath2 = Join-Path $homeDir "scripts\css\pandoc-my-overrides.css"
$outputFile = $MarkdownFile -replace '\.md$', '.html'

$pandocCommand = "pandoc $MarkdownFile -s --self-contained -c $cssPath1 -c $cssPath2 -o $outputFile"

Write-Host $pandocCommand
Write-Host "`n"

Invoke-Expression $pandocCommand

# スクリプトを一時停止
Read-Host -Prompt "Press any key to continue"