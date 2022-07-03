#!/usr/bin/env bash

CONFIGURATION=$1

if [ "$CONFIGURATION" != "Debug" ] && [ "$CONFIGURATION" != "Release" ]; then
  echo "Usage: $0 <Debug/Release>"
  exit 1
fi

set -euo pipefail

excluded_frameworks=("Pods_DummyApp" "DummyApp")

function archive() {
  xcodebuild archive \
    -workspace $PROJECT.xcworkspace \
    -scheme $PROJECT \
    -configuration "$CONFIGURATION" \
    -archivePath $SRCROOT/$PROJECT-iphonesimulator.xcarchive \
    -sdk iphonesimulator \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    ARCHS=arm64\ x86_64 \
    CODE_SIGNING_ALLOWED=NO \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO | xcbeautify

  xcodebuild archive \
    -workspace $PROJECT.xcworkspace \
    -scheme $PROJECT \
    -configuration "$CONFIGURATION" \
    -archivePath $SRCROOT/$PROJECT-iphoneos.xcarchive \
    -sdk iphoneos \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    ARCHS=arm64\ x86_64 \
    CODE_SIGNING_ALLOWED=NO \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO | xcbeautify

  xcodebuild archive \
    -workspace $PROJECT.xcworkspace \
    -scheme $PROJECT \
    -configuration "$CONFIGURATION" \
    -archivePath $SRCROOT/$PROJECT-maccatalyst.xcarchive \
    -sdk macosx \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    ARCHS=arm64\ x86_64 \
    CODE_SIGNING_ALLOWED=NO \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    SUPPORTS_MACCATALYST=YES | xcbeautify
}

function create_xcframework() {
  rm -rf $SRCROOT/Frameworks
  mkdir $SRCROOT/Frameworks

  # Find frameworks
  for framework in $(find $SRCROOT/$PROJECT-iphonesimulator.xcarchive/Products/Library/Frameworks -type d -name "*.framework"); do
    basename=$(basename $framework)
    framework_name=$(basename $framework .framework)

    if [[ " ${excluded_frameworks[*]} " =~ " ${framework_name} " ]]; then
      continue
    fi

    xcodebuild -create-xcframework \
      -framework $SRCROOT/$PROJECT-iphoneos.xcarchive/Products/Library/Frameworks/$basename \
      -framework $SRCROOT/$PROJECT-iphonesimulator.xcarchive/Products/Library/Frameworks/$basename \
      -framework $SRCROOT/$PROJECT-maccatalyst.xcarchive/Products/Library/Frameworks/$basename \
      -output $SRCROOT/Frameworks/$framework_name.xcframework

    echo "Created xcframework: $framework_name.xcframework"
  done

  # Find bundle resources
  for resources in $(find $BUILT_PRODUCTS_DIR/../.. -type d -name "*.bundle"); do
    cp -R $resources $SRCROOT/Frameworks/
  done

  cp README.md Frameworks/
  cp LICENSE Frameworks/
  tar -cvzf ReactNative-binary-"$CONFIGURATION".tar.gz Frameworks
}

function clean() {
  rm -rf $SRCROOT/$PROJECT-iphoneos.xcarchive
  rm -rf $SRCROOT/$PROJECT-iphonesimulator.xcarchive
  rm -rf $SRCROOT/Frameworks
}


cd $SRCROOT

archive
create_xcframework
clean
