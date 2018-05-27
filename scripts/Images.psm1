# Remove all images in the image folder
function Clean-Images () {
    Get-ChildItem -Path .\images\ -Recurse |
        Where {$_.Extension -match "png"} |
        Remove-Item
}

function Generate-Images (
    [String]$Path="./images",
    [Switch]$RefreshImages
) {
    $From = $PWD.Path
    Get-ChildItem -Path $Path -Filter *.tex -Recurse |
    ForEach-Object {
        $RelativeName = ($_.FullName.Replace($From, "") -replace "\\","/").Substring(1)
        Write-Host "Converting $($RelativeName)"
        & Create-Image -Name $_.FullName -RefreshImage:$RefreshImages
        Write-Host ""
    }
    Remove-Item *.log
}

function Create-Image (
    [Parameter(Mandatory=$true)]
    [String]$Name,
    [String]$Number="",
    [Switch]$OutputLaTeX,
    [Switch]$RefreshImage
)
{
    $From = "$($PWD.Path)"

    $FullName = (Convert-Path -Path $Name).Replace($From, "")
    $BaseName = [io.path]::GetFileNameWithoutExtension($Name)
    $Path = (Split-Path $FullName).Substring(1) -replace "\\","/"

    if ((Test-Path "$($Path)\\$($BaseName).png") -And (-not $RefreshImage)) {
        Write-Host "Image $($BaseName).png already exists, skipping"
        return
    }
    else {
        Write-Host "Creating image"
    }

    if ($Path -eq "") {
        $Path = "."
    }

    $RelativeName = "$($Path)/$($BaseName)"
    if ($OutputLaTeX) {
        & pdflatex -halt-on-error -output-directory="$($Path)" "$($RelativeName).tex"
    }
    else {
        & pdflatex -halt-on-error -output-directory="$($Path)" "$($RelativeName).tex" | Out-Null
    }
    bash ./scripts/convert_pdf_to_image.sh "$($RelativeName).pdf" $Number
    Remove-Item "$($RelativeName).*" -Exclude *.tex,*.png,*.gif -Force

    Remove-Item *.log
}

Export-ModuleMember -Function *