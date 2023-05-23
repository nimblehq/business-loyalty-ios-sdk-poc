Pod::Spec.new do |s|
  s.name                  = 'NimbleLoyalty'
  s.version               = '0.2.0'
  s.summary               = 'A SDK supports Loyalty programm'
  s.homepage              = 'https://github.com/nimblehq/business-loyalty-ios-sdk-poc'
  s.author                = { 'Nimble' => 'dev@nimblehq.co' }
  s.license               = { :type => "MIT", :text => "MIT License" }
  s.source                = { :git => "https://github.com/nimblehq/business-loyalty-ios-sdk-poc.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '14.0'
  s.source_files          = 'Sources/**/*'
  s.swift_version         = '5.0'
  s.dependency 'Moya'
  s.dependency 'KeychainAccess'
end
