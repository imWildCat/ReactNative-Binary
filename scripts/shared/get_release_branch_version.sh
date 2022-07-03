#!/usr/bin/env bash

react_native_version=$(cat frontend/package.json | grep react-native | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[[:space:]]' | sed 's/[^0-9.]//g')

release_branch_version=$(echo "$BRANCH_NAME" | sed 's/releases\///g')

if [[ $release_branch_version =~ ^$react_native_version ]]; then
  echo "release branch version must begins with react_native_version" >&2
  exit 1
fi
