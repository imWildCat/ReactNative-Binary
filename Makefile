build:
	scripts/build_xcframework.sh

prepare:
	brew bundle install --no-lock --file Brewfile
