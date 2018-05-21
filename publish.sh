git checkout develop

stack exec site clean
stack exec site build

git checkout master
cp -a _site/* .
git add --all
# git commit -m 'Publish'
# git push