platform :ios, '14.0'
use_frameworks!
inhibit_all_warnings!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'LoyaltySDK' do
  # Network
  pod 'Moya/Combine'

  # Storage
  pod 'KeychainAccess'

  target 'LoyaltySDKTests' do
    testing_pods
  end
end
