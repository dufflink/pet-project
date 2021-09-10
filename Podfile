platform :ios, '11.0'

target 'aimoon-main' do

  inhibit_all_warnings!
  use_frameworks!

  pod 'Moya'
  pod 'KeychainAccess'
  
  pod 'R.swift'
  pod 'SwiftLint'
  
  pod 'Kingfisher'
  pod 'RealmSwift'
  
  pod 'PhoneNumberKit'

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
end
