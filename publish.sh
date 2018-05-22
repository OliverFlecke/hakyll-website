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
git commit -m 'Publish'
git push

# Checkout devolopment branch afterwards
git checkout develop