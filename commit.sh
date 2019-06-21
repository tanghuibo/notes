gitbook build
git add .
git commit -m "$0"
git push --set-upstream origin master
cd _book
git add .
git commit -m "$0"
git push --set-upstream origin gh-pages