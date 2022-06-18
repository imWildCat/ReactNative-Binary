archive: export SRCROOT = $(shell pwd)
archive: export PROJECT = DummyApp
archive:
	zsh scripts/build_xcframework.sh

prepare:
	brew bundle install --no-lock --file Brewfile
	bundle install

gen:
	xcodegen
	bundle exec pod install
