#!/usr/bin/env bash

CONFIGURATION=$1

PLATFORM=$2

if [ "$CONFIGURATION" != "Debug" ] && [ "$CONFIGURATION" != "Release" ]; then
  echo "Usage: $0 <Debug/Release>"
  exit 1
fi

if [ "$PLATFORM" != "iphoneos" ] && [ "$PLATFORM" != "iphonesimulator" ] && [ "$PLATFORM" != "maccatalyst" ]; then
  echo "Usage: $0 <Debug/Release> <iphoneos/iphonesimulator/maccatalyst>"
  exit 1
fi

OUT="$PLATFORM-binary-$CONFIGURATION.tar.gz"

set -euo pipefail

function archive() {
  if [ "$PLATFORM" == "maccatalyst" ]; then
    SUPPORTS_MACCATALYST="YES"
    SDK="macosx"
    DESTINATION="-destination \"generic/platform=OS X\""
  else
    SUPPORTS_MACCATALYST="NO"
    SDK=$PLATFORM
    DESTINATION=""
  fi

  architectures="arm64 x86_64"
  if [ "$PLATFORM" == "iphoneos" ]; then
    architectures="arm64"
  fi

  XCODEBUILD_COMMAND="xcodebuild archive \
    -workspace "$PROJECT.xcworkspace" \
    -scheme $PROJECT \
    -configuration $CONFIGURATION \
    -archivePath $SRCROOT/$PROJECT-$PLATFORM.xcarchive \
    -sdk $SDK \
    $DESTINATION \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    ARCHS=$architectures \
    CODE_SIGNING_ALLOWED=NO \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    SUPPORTS_MACCATALYST=$SUPPORTS_MACCATALYST | xcbeautify"
  # put the command above into a string variable

  echo "Running: $XCODEBUILD_COMMAND"

  eval $XCODEBUILD_COMMAND
}

archive

# Get absolute path of $OUT
OUT=$(pwd)/$OUT

pushd "$SRCROOT/$PROJECT-$PLATFORM.xcarchive/Products/Library/Frameworks" || exit 1

tar -cvf "$OUT" ./*

popd || exit 1
