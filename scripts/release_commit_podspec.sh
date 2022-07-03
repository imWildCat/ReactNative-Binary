#!/usr/bin/env bash

VERSION_TAG=$1

if [ -z "$VERSION_TAG" ]; then
  echo "Usage: $0 <version tag>"
  exit 1
fi

git config user.email "bot@wildcat.io"
git config user.name "WildCat Bot"

git add ReactNative-Binary.podspec || exit 1
git add ReactNative-Binary-Debug.podspec || exit 1
git commit -m "Update podspecs version to $VERSION_TAG [skip ci]" || exit 1
git push || exit 1
