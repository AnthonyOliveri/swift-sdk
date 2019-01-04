#!/bin/bash

# Generate API docs and upload them to Github on the gh-pages branch
# IMPORTANT: This is only meant to be called from Jenkins!

set -e

# Configure Jenkins to be able to push to the Github repo
git config --global user.name "Jenkins"
git remote rm origin
# git remote add origin https://watson-developer-cloud:${GH_TOKEN}@github.com/watson-developer-cloud/swift-sdk.git
git remote add origin https://AnthonyOliveri:${GH_TOKEN}@github.com/watson-developer-cloud/swift-sdk.git
git fetch
git fetch --tags
latestVersion=$(git describe --abbrev=0 --tags)

# Generate the API docs
./Scripts/generate-documentation.sh

# Push newly-generated docs to the gh-pages branch
git checkout --track origin/gh-pages
cp -r gh-pages/* .
rm -rf gh-pages/
git clean -df
git add .
git commit -m "SDK docs for release ${latestVersion}"
git push --set-upstream origin gh-pages
