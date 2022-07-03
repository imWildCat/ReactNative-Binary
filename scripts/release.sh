#!/usr/bin/env bash

# This function assumes that `Release` is run before `Debug`
function prepare_release() {
  version_tag="v$1"
  configuration="$2"
  repo_name="imWildCat/ReactNativeAppleBinaryFramework"
  archive_name="ReactNative-Binary-$version_tag-$configuration.tar.gz"

  if [ $(gh release view "$version_tag") ] && [ "$configuration" == "Release" ]; then
    gh release delete "$version_tag"
    echo "Deleted $version_tag because it is Release node"
  fi

  # if configuration is Release
  if [ "$configuration" == "Release" ]; then
    cp ReactNative-Binary.podspec ReactNative-Binary-Debug.podspec
    gh release create "$version_tag" --generate-notes -R $repo_name
  fi

  mv "ReactNative-binary-$configuration".tar.gz "$archive_name"

  echo "Files:"
  ls -lh

  gh release upload "$version_tag" "$archive_name" -R $repo_name && rm -rf "$archive_name"
  echo "Uploaded $archive_name"
  ls -lh

  if [ "$configuration" == "Debug" ]; then
    spec_file_name="ReactNative-Binary-Debug.podspec"
  else
    spec_file_name="ReactNative-Binary.podspec"
  fi

  sed -i '' "s/version = '[^']*'/version = '$1'/g" "$spec_file_name" || exit 1
  download_url="https://github.com/$repo_name/releases/download/$version_tag/$archive_name"
  escaped_download_url=$(printf '%s\n' $download_url | sed -e 's/[\/&]/\\&/g')
  sed -i '' "s/source = '[^']*'/source = '$escaped_download_url'/g" "$spec_file_name" || exit 1
}

SCRIPT_PATH=$(dirname "${BASH_SOURCE[0]}")

# shellcheck source=./shared/get_release_branch_version.sh
source "$SCRIPT_PATH/get_release_branch_version.sh"

prepare_release "$release_branch_version" Release
prepare_release "$release_branch_version" Debug

echo "git status:"
git status
