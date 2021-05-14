platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

target 'AeroPlan' do
   pod 'Model', :git => 'https://github.com/ilyabochkov1331801/Model', :branch => 'yellow'

   pod 'SwiftLint'
   pod 'SnapKit'
   pod 'Firebase/Analytics'
   pod 'KeychainAccess'
   pod 'Alamofire'
   pod 'GoogleSignIn'

   project 'AeroPlan.xcodeproj'
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    if config.name.include?("Debug")
      config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'

      config.build_settings['ENABLE_TESTABILITY'] = 'YES'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      config.build_settings['SWIFT_COMPILATION_MODE'] = 'singlefile'

      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
      if !config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'].include? 'DEBUG=1'
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'DEBUG=1'
      end
    end
  end

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|

      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'

      if config.name.include?("Debug")
        config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'

        config.build_settings['ENABLE_TESTABILITY'] = 'YES'
        config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
        config.build_settings['SWIFT_COMPILATION_MODE'] = 'singlefile'

        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
        if !config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'].include? 'DEBUG=1'
          config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'DEBUG=1'
        end

        config.build_settings['ENABLE_NS_ASSERTIONS'] = 'YES'

        config.build_settings['OTHER_CFLAGS'] ||= ['$(inherited)']
        if config.build_settings['OTHER_CFLAGS'].include? '-DNS_BLOCK_ASSERTIONS=1'
          config.build_settings['OTHER_CFLAGS'].delete('-DNS_BLOCK_ASSERTIONS=1')
        end
      end
    end
  end
end
