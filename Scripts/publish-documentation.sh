#!/bin/bash

# Generate API docs and upload them to Github on the gh-pages branch

echo "1"
sh ./generate-documentation.sh
echo "2"
git checkout gh-pages
echo "3"
cp -r gh-pages/* .
echo "4"
rm -rf gh-pages/
echo "5"
git clean -df
echo "6"
git add .
echo "7"
# Get the release version from the latest git tag
git commit -m "SDK docs for release $(git describe --abbrev=0 --tags)"
echo "8"
git push
echo "9"