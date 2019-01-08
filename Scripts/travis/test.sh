set -e

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then brew update ; fi
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then brew outdated carthage || brew upgrade carthage ; fi
openssl aes-256-cbc -K $encrypted_d84ac0b7eb5c_key -iv $encrypted_d84ac0b7eb5c_iv -in Source/SupportingFiles/WatsonCredentials.swift.enc -out Source/SupportingFiles/WatsonCredentials.swift -d

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then pod repo update master --silent ; fi # Gets the latest version of RestKit
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then carthage update --platform iOS ; fi
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then sudo apt-get -qq update -y ; fi
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then wget https://swift.org/builds/swift-4.1-release/ubuntu1404/swift-4.1-RELEASE/swift-4.1-RELEASE-ubuntu14.04.tar.gz -q; fi
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then tar xzf swift-4.1-RELEASE-ubuntu14.04.tar.gz ; fi
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then export PATH=swift-4.1-RELEASE-ubuntu14.04/usr/bin:$PATH ; fi

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then ./Scripts/run-tests.sh ; fi
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then ./Scripts/pod-lint.sh ; fi
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then swift build ; fi
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then swift test ; fi