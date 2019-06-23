# !/bin/bash

git push origin :gh-pages
rm -rf ./_book
gitbook build
cd _book
git init
git checkout -b gh-pages
git remote add origin https://github.com/sveltejs-cn/test.git
git add --all
git commit -m 'publish'
git push origin gh-pages
