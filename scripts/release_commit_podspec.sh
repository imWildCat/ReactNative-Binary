#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "SCRIPT_DIR: $SCRIPT_DIR"

# shellcheck source=./shared/get_release_branch_version.sh
source "$SCRIPT_DIR/shared/get_release_branch_version.sh"

git config user.email "bot@wildcat.io"
git config user.name "WildCat Bot"

git add ReactNative-Binary.podspec || exit 1
git add ReactNative-Binary-Debug.podspec || exit 1
git commit -m "Update podspecs version to $release_branch_version [skip ci]" || exit 1
git push || exit 1
