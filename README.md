This NimbleLoyalty SDK is a library that allows developers to integrate loyalty programs into their iOS applications easily. The SDK provides a set of features that enable the user to authenticate, get a list of available rewards, redeem a reward, and retrieve their reward history.

## Features

- Authenticate (via Auth0)
- Get reward list
- Redeem reward
- Get reward history

## Component Library

- Moya
- KeychainAccess

## Requirements

- iOS 14.0+
- Xcode 14.0+

## Installation

The iOS Loyalty SDK can be installed using either CocoaPods or Swift Package Manager.

### CocoaPods

To install using CocoaPods, add the following line to your Podfile:

```
pod 'iOSLoyaltySDK', '~> 1.0'
```

### Swift Package Manager

To install using Swift Package Manager, add the following line to your dependencies:

```swift
.package(url: "https://github.com/nimblehq/business-loyalty-ios-sdk-poc.git", from: "0.1.0")
```

## Credit

<picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png">
    <img alt="Nimble logo" src="https://assets.nimblehq.co/logo/light/logo-light-text-160.png">
  </picture>

This project is maintained and funded by Nimble.

## License

This SDK is licensed under the MIT License. See the [LICENSE] file for more information.
