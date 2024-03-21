require_relative './frontend/node_modules/react-native/scripts/react_native_pods'
require_relative './frontend/node_modules/@react-native-community/cli-platform-ios/native_modules'

platform :ios, min_ios_version_supported

prepare_react_native_project!

linkage = ENV['USE_FRAMEWORKS']
unless linkage.nil?
  Pod::UI.puts "Configuring Pod with #{linkage}ally linked Frameworks".green
  use_frameworks! linkage: linkage.to_sym
end

target 'DummyApp' do
  # config = use_native_modules!

  use_react_native!(
    path: './frontend/node_modules/react-native',
    # production: ,
    fabric_enabled: false,
    hermes_enabled: true,
    app_path: "#{Pod::Config.instance.installation_root}/frontend"
  )

  post_install do |installer|
    react_native_post_install(
      installer,
      './frontend/node_modules/react-native',
      # Set `mac_catalyst_enabled` to `true` in order to apply patches
      # necessary for Mac Catalyst builds
      mac_catalyst_enabled: true
    )
  end
end
