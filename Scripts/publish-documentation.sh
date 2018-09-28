#!/bin/bash

# Generate API docs and upload them to Github on the gh-pages branch
# Note that this is only meant to be called from Travis builds

set -e

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git config --replace-all remote.origin.fetch +refs/heads/*:refs/remotes/origin/*
git remote rm origin
git remote add origin https://AnthonyOliveri:${GH_TOKEN}@github.com/AnthonyOliveri/swift-sdk.git
git fetch
git fetch --tags
latestVersion=$(git describe --abbrev=0 --tags)

./Scripts/generate-documentation.sh

git checkout --track origin/gh-pages
cp -r gh-pages/* .
rm -rf gh-pages/
git clean -df
git add .
git commit -m "SDK docs for release ${latestVersion}"
git push --set-upstream origin gh-pages