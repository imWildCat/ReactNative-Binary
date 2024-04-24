gen:
	xcodegen
	RCT_NEW_ARCH_ENABLED=0 USE_FRAMEWORKS=dynamic pod install

bundle:
	cd scripts && yarn bundle-ios

install:
	cd scripts && yarn

open:
	xed ReactNativeBinaryExample.xcworkspace
