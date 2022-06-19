archive: export SRCROOT = $(shell pwd)
archive: export PROJECT = DummyApp
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

link-ccache:
	scripts/force_link_ccache.sh

unlink-ccache:
	scripts/force_link_ccache.sh clean
