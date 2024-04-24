gen:
	xcodegen
	RCT_NEW_ARCH_ENABLED=0 USE_FRAMEWORKS=dynamic pod install

bundle:
	cd scripts && npm run bundle-ios

install:
	cd scripts && npm install

open:
	xed ReactNativeBinaryExample.xcworkspace

build:
	xcodebuild -workspace ReactNativeBinaryExample.xcworkspace \
           -scheme ReactNativeBinaryExample \
           -destination 'platform=iOS Simulator,name=iPhone 14' \
           CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO \
           | xcbeautify
