gen:
	tuist generate
	pod install

bundle:
	npx react-native bundle --platform ios --dev false --entry-file scripts/index.jsx --bundle-output example/Targets/ReactNativeBinaryExampleUI/Sources/generated/index.jsbundle

yarn-install:
	cd ../frontend/ && yarn install
