Get-ChildItem "images/" -Filter *.tex |
ForEach-Object {
    Write-Host $_.Name
}