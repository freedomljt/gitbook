# 发布到Github pages

```
touch .gitignore
echo "_book" >> .gitignore
git add .gitignore
git commit -m "Ignore book"
gitbook build
cp -r _book/* .
git add .
git commit -m "Publish"
```