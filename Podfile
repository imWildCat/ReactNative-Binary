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

post_install do |installer|
  # react_native_post_install(installer)

  # ...possibly other post_install items here

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Using the un-qualified names means you can swap in different implementations, for example ccache
      config.build_settings['CC'] = '$(PODS_ROOT)/../scripts/ccache-clang'
      config.build_settings['LD'] = '$(PODS_ROOT)/../scripts/ccache-clang'
      config.build_settings['CXX'] = '$(PODS_ROOT)/../scripts/ccache-clang++'
      config.build_settings['LDPLUSPLUS'] = '$(PODS_ROOT)/../scripts/ccache-clang++'
    end
  end

  __apply_Xcode_12_5_M1_post_install_workaround(installer)
end
