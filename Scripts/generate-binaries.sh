#!/bin/bash

pushd `dirname $0` > /dev/null
root=`pwd`
popd > /dev/null
cd $root
cd ..

carthage update --platform iOS --no-use-binaries
carthage build --no-skip-current
carthage archive --output IBMWatsonSwiftSDK.zip