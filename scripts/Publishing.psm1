
function Publish(
    [Parameter(Mandatory=$true)]
    [String]$Message
) {
    git checkout master

    $Branch = git rev-parse --abbrev-ref HEAD
    if (-not ($Branch -eq "master")) {
        Write-Warning "Unable to checkout master branch."
        Write-Warning "Check that all files are committed and try again."
        return
    }

    # Copy everything to the root
    Copy-Item -Path _site/* -Destination . -Recurse -Force

    # Commit and publish
    git add --all
    git commit -m $Message
    git push

    # Checkout development branch afterwards
    git checkout develop
}

Export-ModuleMember -Function *