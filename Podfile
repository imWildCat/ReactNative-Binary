# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

require_relative './frontend/node_modules/react-native/scripts/react_native_pods'
require_relative './frontend/node_modules/@react-native-community/cli-platform-ios/native_modules'

target 'DummyApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  use_react_native!(
    path: './frontend/node_modules/react-native',
    production: false,
    fabric_enabled: false,
    hermes_enabled: false
  )
end
