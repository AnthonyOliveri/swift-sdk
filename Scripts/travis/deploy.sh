sudo easy_install pip
nvm install node
nvm use node
gem install cocoapods
gem install jazzy
sudo pip install bumpversion
npm install -g semantic-release@15.9.0
npm install -g @semantic-release/exec
npm install -g @semantic-release/changelog
npm install -g @semantic-release/git
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then brew update ; fi
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then brew outdated carthage || brew upgrade carthage ; fi
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then carthage update --platform iOS ; fi

npx semantic-release
./Scripts/release-to-cocoapods.sh