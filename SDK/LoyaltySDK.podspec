Pod::Spec.new do |s|  
  s.name                = 'LoyaltySDK'
  s.version             = '0.0.1'
  s.summary             = 'LoyaltySDK'
  s.homepage            = 'https://github.com/nimblehq/business-loyalty-ios-sdk-poc'
  s.static_framework    = true
  s.author              = { 'David' => 'duc@nimblehq.co' }
  s.license             = { :type => "MIT", :text => "MIT License" }
  s.platform            = :ios, "14.0"
  s.source              = { :git => "https://github.com/nimblehq/business-loyalty-ios-sdk-poc.git", :tag => "#{s.version}" }
  s.source_files        = "Classes", "LoyaltySDK/**/*.{h,m,swift}"
  s.resource_bundle     = { "LoyaltySDK" => ["LoyaltySDK/*.lproj/*.strings,xcassets"] }
  s.resources           = "LoyaltySDK/**/*.{png,jpeg,jpg,ttf,storyboard,xib,strings,xcassets,mp3,json,wav,gif,bundle}"
  s.dependency 'Moya/Combine', '15.0.0'
  s.dependency 'KeychainAccess', '4.2.2'
end 
