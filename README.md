This NimbleLoyalty SDK library allows developers to easily integrate loyalty programs into their iOS applications.

- [Features](#features)
- [Component Libraries](#component-libraries)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Features

- Authenticate
- Get reward list
- Redeem reward
- Get reward history

## Component Libraries

- Moya
- KeychainAccess

## Requirements

- iOS 14.0+
- Xcode 14.0+

## Installation

The iOS Loyalty SDK can be installed using CocoaPods or Swift Package Manager.

### CocoaPods

To install using CocoaPods, add the following line to your Podfile:

```
pod 'NimbleLoyalty', '~> 0.1.0'
```

### Swift Package Manager

To install using Swift Package Manager, add the following line to your dependencies:

```swift
.package(url: "https://github.com/nimblehq/business-loyalty-ios-sdk-poc.git", from: "0.1.0")
```

## Usage

#### Authentication

Before authenticating the user, remember to set the **clientId** and **clientSecret**.

```swift
NimbleLoyalty.shared.setClientId("CLIENT_ID")
NimbleLoyalty.shared.setClientSecret("CLIENT_SECRET")
```

##### isAuthenticated()

Checks if the user is authenticated.

```swift
if NimbleLoyalty.shared.isAuthenticated() {
    // The user is authenticated, do something
} else {
    // The user is not authenticated, show a login button
}
```

##### authenticate(completion:)

Initiates the authentication flow.

```swift
NimbleLoyalty.shared.authenticate { result in
    switch result {
    case .success:
        // The user is authenticated, do something
    case .failure(let error):
    	print("Error authenticating: \(error.localizedDescription)")
    }
}
```

##### clearSession()

Remove the session, effectively logging the user out.

```swift
// Clear the user's session
NimbleLoyalty.shared.clearSession()
```

#### Get Reward List

Retrieves the list of available rewards for the authenticated user.

```swift
NimbleLoyalty.shared.getRewardList { result in
   switch result {
   case .success(let rewardList):
       // Display the list of rewards to the user
       for reward in rewardList.rewards {
           print("Reward name: \(reward.name)")
       }
   case .failure(let error):
       print("Error retrieving rewards: \(error.localizedDescription)")
   }
}
```

#### Redeem a Reward

Redeems a reward with the given reward's code for the authenticated user.

```swift
NimbleLoyalty.shared.redeemReward(code: "ABC123") { result in
   switch result {
   case .success(let rewardList):
       print("Reward redeemed with ID: \(redeemReward.id)")
   case .failure(let error):
       print("Error redeeming reward: \(error.localizedDescription)")
   }
}
```

#### Get Reward History

Retrieves the reward history for the authenticated user.

```swift
NimbleLoyalty.shared.getRewardHistory { result in
   switch result {
   case .success(let rewardHistory):
       // Display the reward history to the user
       for reward in rewardHistory {
           print("Reward name: \(reward.name)")
       }
   case .failure(let error):
       print("Error retrieving reward history: \(error.localizedDescription)")
   }
}
```

## Credits

<picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png">
    <img alt="Nimble logo" src="https://assets.nimblehq.co/logo/light/logo-light-text-160.png">
  </picture>

This project is maintained and funded by Nimble.

## License

This project is Copyright (c) 2023 and onwards Nimble. It is free software and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE
