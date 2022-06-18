#!/bin/bash

set -euo pipefail

# export PATH="/usr/local/bin:$PATH"
# export PATH="/opt/homebrew/bin/:$PATH"

# Sample catalyst build command:
# xcodebuild clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ARCHS=arm64\ x86_64 SUPPORTS_MACCATALYST=YES -workspace DummyApp.xcworkspace -sdk macosx -scheme DummyApp   | grep macabi
# Sample iOS build command:
# xcodebuild build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ARCHS=arm64\ x86_64 -workspace DummyApp.xcworkspace -sdk iphonesimulator -scheme DummyApp  | xcbeautify

exclude_frameworks=("PINCache" "PINOperation" "PINRemoteImage" "Pods_DummyApp" "DummyApp")

function archive() {
  xcodebuild archive \
    -workspace $PROJECT.xcworkspace \
    -scheme $PROJECT \
    -archivePath $SRCROOT/$PROJECT-iphonesimulator.xcarchive \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO \
    ARCHS=arm64\ x86_64 CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO | xcbeautify

  xcodebuild archive \
    -workspace $PROJECT.xcworkspace \
    -scheme $PROJECT \
    -archivePath $SRCROOT/$PROJECT-iphoneos.xcarchive \
    -sdk iphoneos \
    SKIP_INSTALL=NO \
    ARCHS=arm64\ x86_64 CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO | xcbeautify
}

function create_xcframework() {
  rm -rf $SRCROOT/Frameworks
  mkdir $SRCROOT/Frameworks

  # Find frameworks
  for framework in $(find $SRCROOT/$PROJECT-iphonesimulator.xcarchive/Products/Library/Frameworks -type d -name "*.framework"); do
    basename=$(basename $framework)
    framework_name=$(basename $framework .framework)

    if [[ " ${exclude_frameworks[*]} " =~ " ${framework_name} " ]]; then
      continue
    fi

    xcodebuild -create-xcframework \
      -framework $SRCROOT/$PROJECT-iphonesimulator.xcarchive/Products/Library/Frameworks/$basename \
      -framework $SRCROOT/$PROJECT-iphoneos.xcarchive/Products/Library/Frameworks/$basename \
      -output $SRCROOT/Frameworks/$framework_name.xcframework
  done

  # Find bundle resources
  for resources in $(find $BUILT_PRODUCTS_DIR/../.. -type d -name "*.bundle"); do
    cp -R $resources $SRCROOT/Frameworks/
  done

  tar -cvzf $PROJECT.tar.gz Frameworks
}

function clean() {
  # Clean Up
  rm -rf $SRCROOT/$PROJECT-iphoneos.xcarchive
  rm -rf $SRCROOT/$PROJECT-iphonesimulator.xcarchive
  rm -rf $SRCROOT/Frameworks
}

function distribute() {
  echo "dummy release"
  # gh release create "$1" --generate-notes -R "imWildCat/DummyApp"
  # gh release upload "$1" $PROJECT.tar.gz -R "imWildCat/DummyApp" && rm -rf $PROJECT.tar.gz

  # pod repo push imWildCat DummyApp.podspec --verbose --allow-warnings --skip-tests
}

cd $SRCROOT
# version=$(cat DummyApp.podspec | grep version | sed -n 's/version.=."\(.*\)".*/\1/p' | xargs)
version="1.0"

archive
create_xcframework
clean
distribute $version
