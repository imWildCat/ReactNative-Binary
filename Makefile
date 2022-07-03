export SRCROOT = $(shell pwd)
export PROJECT = DummyApp

archive:
	scripts/build_xcframework.sh $(CONFIGURATION)

prepare:
	brew bundle install --no-lock --file Brewfile
	bundle install
	cd frontend && yarn install

gen:
	xcodegen
	bundle exec pod install
	scripts/patch_catalyst.sh
	scripts/set_up_xcode_env.sh

release:
	scripts/release.sh $(CONFIGURATION)

publish:
	bundle exec pod trunk push ReactNative-Binary.podspec --allow-warnings

clean:
	rm -rf ./build
	rm -rf ./Pods
	rm -rf DummyApp.xcworkspace
	rm -rf DummyApp.xcodeproj
	rm -rf ./DerivedData
