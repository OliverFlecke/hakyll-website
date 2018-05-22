if [ $# -eq 0 ]
  then
    echo "No publish message supplied"
    exit 1
fi

git checkout develop
git stash

# Clean and build the site
stack build
stack exec site clean
stack exec site build

git checkout master

# Copy everything to the root
cp -a _site/* .

# Commit and publish
git add --all
git commit -m $1
git push

# Checkout devolopment branch afterwards
git checkout develop