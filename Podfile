require Pod::Executable.execute_command('node', ['-p',
  'require.resolve(
    "./frontend/node_modules/react-native/scripts/react_native_pods.rb",
    {paths: [process.argv[1]]},
  )', __dir__]).strip


platform :ios, min_ios_version_supported

prepare_react_native_project!

linkage = ENV['USE_FRAMEWORKS']
unless linkage.nil?
  Pod::UI.puts "Configuring Pod with #{linkage}ally linked Frameworks".green
  use_frameworks! linkage: linkage.to_sym
end

target 'DummyApp' do
  config = use_native_modules!({
    'project': {
      'ios': {
        'sourceDir': './',
      }
    }
  })

  use_react_native!(
    path: './frontend/node_modules/react-native',
    # production: ,
    fabric_enabled: true,
    hermes_enabled: true,
    app_path: "#{Pod::Config.instance.installation_root}/frontend"
  )

  post_install do |installer|
    # https://github.com/facebook/react-native/blob/main/packages/react-native/scripts/react_native_pods.rb#L197-L202
    react_native_post_install(
      installer,
      config[:reactNativePath],
      :mac_catalyst_enabled => true
    )
  end
end
