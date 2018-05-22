Get-ChildItem . -Filter *.tex |
ForEach-Object {
    Write-Host "Converting $($_.Name)"
    & pdflatex $_.Name -halt-on-error > $NULL
    bash ./convert_pdf_to_image.sh "$($_.BaseName).pdf"
    Remove-Item "$($_.BaseName).*" -Exclude *.tex,*.png,*.gif -Force
}
Remove-Item *.log