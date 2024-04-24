gen:
	xcodegen
	RCT_NEW_ARCH_ENABLED=0 USE_FRAMEWORKS=dynamic pod install

bundle:
	cd scripts && npm run bundle-ios

install:
	cd scripts && npm install

open:
	xed ReactNativeBinaryExample.xcworkspace
