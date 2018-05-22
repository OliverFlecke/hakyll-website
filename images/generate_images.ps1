Get-ChildItem . -Filter *.tex |
ForEach-Object {
    & pdflatex $_.Name -halt-on-error > $NULL
    bash ./convert_pdf_to_image.sh "$($_.BaseName).pdf"
    Remove-Item "$($_.BaseName).*" -Exclude *.tex,*.png,*.gif -Force
}