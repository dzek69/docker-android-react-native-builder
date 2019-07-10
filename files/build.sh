#!/bin/bash
set -e

ls -lah /tmp/app
echo " ... "
cp -r /tmp/app /tmp/build
cd /tmp/build

yarn --production
yarn build:release:android

echo Copying app-release.apk into /result

cp /tmp/build/android/app/build/outputs/apk/release/app-release.apk /result
