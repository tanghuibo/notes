gitbook build
git add .
git commit -m "$1"
git push
cd _book
git init
git remote add origin git@github.com:tanghuibo/notes.git
git checkout -b gh-pages
git add .
git commit -m "$1"
git push --set-upstream origin gh-pages