#!/bin/bash

# Generate API docs and upload them to Github on the gh-pages branch
# Note that this is only meant to be called from Travis builds

set -ev

git config --replace-all remote.origin.fetch +refs/heads/*:refs/remotes/origin/*
git fetch
git checkout -b develop origin/develop
./Scripts/generate-documentation.sh
git checkout -b gh-pages origin/gh-pages
cp -r gh-pages/* .
rm -rf gh-pages/
git clean -df
git add .
# Get the release version from the latest git tag
git commit -m "SDK docs for release $(git describe --abbrev=0 --tags)"
git push