# HaventecAuthenticate

[![Version](https://img.shields.io/cocoapods/v/HaventecAuthenticate.svg?style=flat)](https://cocoapods.org/pods/HaventecAuthenticate)
[![License](https://img.shields.io/cocoapods/l/HaventecAuthenticate.svg?style=flat)](https://cocoapods.org/pods/HaventecAuthenticate)
[![Platform](https://img.shields.io/cocoapods/p/HaventecAuthenticate.svg?style=flat)](https://cocoapods.org/pods/HaventecAuthenticate)

A collection of functions for native iOS apps to facilitate the integration with Haventec Authenticate

## Installation

HaventecAuthenticate is available through [CocoaPods](https://cocoapods.org/pods/HaventecAuthenticate). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HaventecAuthenticate'
```

Afterwards, make sure to run pod install in your working project directory.

## Usage

Import the main class HaventecAuthenticate:

```
import HaventecAuthenticate;
```    


This class has the following methods:

* **initialiseStorage:** It initilises the Android Storage for a specific Haventec Authenticate user. Your app has to call this method once you know the username of the user.

* **updateStorage:** It updates the Android Storage with the new user details. Whenever your app invokes a method that changes the authentication state (add user, add device, activate user, activate device, or login), your app must update the Haventec SDK storage using this method.

* **hashPin:** It returns a SHA-512 Hashing of the PIN passed as argument. 

* **getAccessToken:** It returns the session access token of the current authenticated user from the Android Storage

* **getAuthKey:** It returns the current authKey of the current user from the Android Storage

* **getUsername:** It returns the username of the current user from the Android Storage.

* **getDeviceUuid:** It returns the deviceUuid of the current user from the Android Storage

To initialise, call the initialiseStorage method. This provisions the device persisted storage for the username.

Whenever you invoke a method that changes the authentication state of the device - add user, add device, activate user,
activate device, login - you must update the Haventec SDK storage, using updateStorage.
This can accept the NSData object directly returned from any of these endpoints.

In order to authenticate with Haventec endpoints, a hashed version of the pincode is required, so the hashPin method is used for that.

The rest of the methods provide easy access to the data that is required for the Haventec endpoints.

## Demo app

To run the example project, you need to perform the following:

1. Clone the repo
2. Update the app configuration file in "/Example/HaventecAuthenticate/App.example.plist" with appropriate values
3. Rename "/Example/HaventecAuthenticate/App.example.plist" to "/Example/HaventecAuthenticate/App.plist" for the app target build to use that config.
4. Finally, run the HaventecAuthenticate-Example target build on a iOS device in xCode.

## Requirements

No dependencies are required for this SDK.

## Author

Haventec - (https://www.haventec.com/)

## License

HaventecAuthenticate is available under the MIT license. See the LICENSE file for more info.
