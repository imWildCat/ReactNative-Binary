gen:
	tuist generate --no-open
	RCT_NEW_ARCH_ENABLED=0 USE_FRAMEWORKS=dynamic pod install

bundle:
	cd scripts && yarn bundle-ios

yarn-install:
	cd scripts && yarn

build:
	tuist build

open:
	xed ReactNativeBinaryExample.xcworkspace

tuist-install:
	curl -Ls https://install.tuist.io | bash
