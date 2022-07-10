#!/usr/bin/env bash

CONFIGURATION=$1

if [ "$CONFIGURATION" != "Debug" ] && [ "$CONFIGURATION" != "Release" ]; then
  echo "Usage: $0 <Debug/Release>"
  exit 1
fi

set -euo pipefail

excluded_frameworks=("Pods_DummyApp" "DummyApp")

function unzip_archives() {
  PLATFORM="$1"
  CONFIGURATION="$2"

  tar zxvf "./$PLATFORM-binary-$CONFIGURATION.tar.gz" --directory ./"$PLATFORM"_"$CONFIGURATION"
}


function create_xcframework() {
  rm -rf $SRCROOT/Frameworks
  mkdir $SRCROOT/Frameworks

  # Find frameworks
  for framework in $(find ./iphonesimulator.xcarchive/Products/Library/Frameworks -type d -name "*.framework"); do
    basename=$(basename $framework)
    framework_name=$(basename $framework .framework)

    if [[ " ${excluded_frameworks[*]} " =~ " ${framework_name} " ]]; then
      continue
    fi

    xcodebuild -create-xcframework \
      -framework iphonesimulator_"$CONFIGURATION"/$basename \
      -framework iphoneos_"$CONFIGURATION"/$basename \
      -framework maccatalyst_"$CONFIGURATION"/$basename \
      -output $SRCROOT/Frameworks/$framework_name.xcframework

    echo "Created xcframework: $framework_name.xcframework"
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

unzip_archives iphoneos $CONFIGURATION
unzip_archives iphonesimulator $CONFIGURATION
unzip_archives maccatalyst $CONFIGURATION

create_xcframework
# clean
