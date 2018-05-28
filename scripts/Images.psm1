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
    $RelativeName = "$($Path)/$($BaseName)"

    $ImageName = "$($Path)\\$($BaseName).png"
    if ((Test-Path -Path $ImageName) -And (-not $RefreshImage)) {
        $Image = Get-Item -Path $ImageName
        $TexFile = Get-Item "$($RelativeName).tex"

        if ([datetime]$Image.LastWriteTime -lt [datetime]$TexFile.LastWriteTime) {
            Write-Host "Tex file is newer than image. Refreshing image"
        }
        else {
            Write-Host "Image $($BaseName).png already exists, skipping"
            return
        }
    }

    Write-Host "Creating image"
    if ($Path -eq "") {
        $Path = "."
    }

    if ($OutputLaTeX) {
        & pdflatex -halt-on-error -output-directory="$($Path)" "$($RelativeName).tex"
    }
    else {
        & pdflatex -halt-on-error -output-directory="$($Path)" "$($RelativeName).tex" | Out-Null
    }
    bash ./scripts/convert_pdf_to_image.sh "$($RelativeName).pdf" $Number
    Remove-Item "$($RelativeName).*" -Exclude *.tex,*.png,*.gif -Force
}

Export-ModuleMember -Function *