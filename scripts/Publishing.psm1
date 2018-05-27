
function Publish(
    [Parameter(Mandatory=$true)]
    [String]$Message
) {
    git checkout develop
    git stash

    # Clean and build the site
    bash stack build
    bash stack exec site clean
    bash stack exec site build

    git checkout master

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