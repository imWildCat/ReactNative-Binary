#!/usr/bin/env bash
function distribute() {
  version_tag="v$1"
  repo_name="imWildCat/ReactNativeAppleBinaryFramework"
  archive_name="ReactNative-Binary-$version_tag.tar.gz"

  if [ $(gh release view "$version_tag") ]; then
    gh release delete "$version_tag"
  fi

  gh release create "$version_tag" --generate-notes -R $repo_name
  mv "$PROJECT".tar.gz "$archive_name"
  gh release upload "$version_tag" "$archive_name" -R $repo_name && rm -rf "$archive_name"

  sed -i '' "s/version = '[^']*'/version = '$1'/g" ReactNative-Binary.podspec
  download_url="https://github.com/$repo_name/releases/download/$version_tag/$archive_name"
  escaped_download_url=$(printf '%s\n' $download_url | sed -e 's/[\/&]/\\&/g')
  sed -i '' "s/source = '[^']*'/source = '$escaped_download_url'/g" ReactNative-Binary.podspec

  git config user.email "bot@wildcat.io"
  git config user.name "WildCat Bot"

  git add ReactNative-Binary.podspec
  git commit -m "Update ReactNative-Binary.pospec version to $version_tag [skip ci]"
  git push
  # pod repo push imWildCat ReactNative-Binary.podspec --verbose --allow-warnings --skip-tests
}

react_native_version=$(cat frontend/package.json | grep react-native | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[[:space:]]' | sed 's/[^0-9.]//g')

distribute $react_native_version
