#!/usr/bin/env bash

CONFIGURATION=$1

PLATFORM=$2

OUT=$3

if [ "$CONFIGURATION" != "Debug" ] && [ "$CONFIGURATION" != "Release" ]; then
  echo "Usage: $0 <Debug/Release>"
  exit 1
fi

if [ "$PLATFORM" != "iphoneos" ] && [ "$PLATFORM" != "iphonesimulator" ] && [ "$PLATFORM" != "maccatalyst" ]; then
  echo "Usage: $0 <Debug/Release> <iphoneos/iphonesimulator/maccatalyst>"
  exit 1
fi

if [ -z "$OUT" ]; then
  echo "OUT should be set"
  echo "Usage: $0 <Debug/Release> <iphoneos/iphonesimulator/maccatalyst> <OUT>"
  exit 1
fi

set -euo pipefail

function archive() {
  xcodebuild archive \
    -workspace $PROJECT.xcworkspace \
    -scheme $PROJECT \
    -configuration "$CONFIGURATION" \
    -archivePath $SRCROOT/$PROJECT-$PLATFORM.xcarchive \
    -sdk $PLATFORM \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    ARCHS=arm64\ x86_64 \
    CODE_SIGNING_ALLOWED=NO \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO | xcbeautify
}

archive

zip -r $OUT $SRCROOT/$PROJECT-$PLATFORM.xcarchive/Products/Library/Frameworks
