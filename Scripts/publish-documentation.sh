#!/bin/bash

# Generate API docs and upload them to Github on the gh-pages branch

sh ./generate-documentation.sh
git checkout gh-pages
cp -r gh-pages/* .
rm -rf gh-pages/
git clean -df
git add .
# Get the release version from the latest git tag
git commit -m "SDK docs for release $(git describe --abbrev=0 --tags)"
git push