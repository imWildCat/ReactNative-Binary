export SRCROOT = $(shell pwd)
export PROJECT = DummyApp

archive:
	scripts/build_xcframework.sh

prepare:
	brew bundle install --no-lock --file Brewfile
	bundle install
	cd frontend && yarn install

gen:
	xcodegen
	bundle exec pod install
	scripts/patch_catalyst.sh

release:
	scripts/release.sh
