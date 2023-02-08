version = '0.71.2'

source = 'https://github.com/imWildCat/ReactNativeAppleBinaryFramework/releases/download/v0.71.2/ReactNative-Binary-v0.71.2-Debug.tar.gz'

Pod::Spec.new do |s|
  s.name                      = 'ReactNative-Binary-Debug'
  s.version                   = version.to_s
  s.summary                   = 'React Native xcframeworks'
  s.description               = <<-DESC
                                   React Native prebuilt xcframeworks for iOS
  DESC
  s.homepage                  = 'https://github.com/imWildCat/ReactNative-Binary'
  s.author                    = 'imWildCat'
  s.license                   = { type: 'MIT', file: 'LICENSE' }
  s.platforms                 = { ios: '12.4' }
  s.source                    = {
    http: source
  }
  s.framework                 = 'JavaScriptCore', 'AudioToolbox'
  s.libraries                 = 'stdc++'

  s.subspec 'main' do |main|
    main.vendored_frameworks  = '**/*.xcframework'
    main.resources            = '**/*.bundle'
  end

  s.default_subspecs = 'main'
end
