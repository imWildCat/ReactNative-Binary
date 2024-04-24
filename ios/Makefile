export SRCROOT = $(shell pwd)
export PROJECT = DummyApp

build-xcframework:
	scripts/build_xcframework.sh $(CONFIGURATION)

archive-platform:
	scripts/build_single_platform.sh $(CONFIGURATION) $(PLATFORM) $(PLATFORM).tar.gz

brew-install:
	brew bundle install --no-lock --file Brewfile

prepare:
	bundle install
	cd frontend && yarn install

gen:
	xcodegen
	RCT_NEW_ARCH_ENABLED=0 USE_FRAMEWORKS=dynamic bundle exec pod install
	scripts/patch_catalyst.sh
	scripts/set_up_xcode_env.sh

release:
	scripts/release.sh
	scripts/release_commit_podspec.sh

publish:
	bundle exec pod trunk push ReactNative-Binary.podspec --allow-warnings
	bundle exec pod trunk push ReactNative-Binary-Debug.podspec --allow-warnings

clean:
	rm -rf ./build
	rm -rf ./Pods
	rm -rf DummyApp.xcworkspace
	rm -rf DummyApp.xcodeproj
	rm -rf ./DerivedData

validate-archive:
	scripts/validate_archive_size.sh $(FILE_PATH)
