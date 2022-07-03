# Uncomment the next line to define a global platform for your project
platform :ios, '12.4'

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

  current_path = Dir.pwd

  ccache_clang_path = File.join(current_path, 'scripts/ccache/ccache-clang')
  ccache_clang_plusplus_path = File.join(current_path, 'scripts/ccache/ccache-clang++')

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['CC'] = ccache_clang_path
        config.build_settings['LD'] = ccache_clang_path
        config.build_settings['CXX'] = ccache_clang_plusplus_path
        config.build_settings['LDPLUSPLUS'] = ccache_clang_plusplus_path
      end
    end
  end
end
