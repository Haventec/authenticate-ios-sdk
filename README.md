# HaventecAuthenticate

[![Version](https://img.shields.io/cocoapods/v/HaventecAuthenticate.svg?style=flat)](https://cocoapods.org/pods/HaventecAuthenticate)
[![License](https://img.shields.io/cocoapods/l/HaventecAuthenticate.svg?style=flat)](https://cocoapods.org/pods/HaventecAuthenticate)
[![Platform](https://img.shields.io/cocoapods/p/HaventecAuthenticate.svg?style=flat)](https://cocoapods.org/pods/HaventecAuthenticate)

## Usage

The main functionality provided relates to the SHA-512 Hashing of the PIN that is required by Haventec Authenticate endpoints,
so these SDK functions provide a convenient and consistent way of implementing these functions in an Android app.

To use the SDK, import the following class and its dependencies:
```
import com.haventec.authenticate.android.sdk.api.HaventecAuthenticate;
```

This class has the following methods:
```
public class HaventecAuthenticate {

  /**
   It creates a Hash of the pin, along with the salt that is in Storage

   - Parameter pin: The PIN code.

   - Throws: `HaventecAuthenticateError.initialiseError`
   if the initialiseStorage function has not been called.

   - Returns: String Base64-encoded representation of the SHA-512 hashed `pin` and stored salt.
  */
  public static func hashPin(pin: String) throws -> String? {
  }

  /**
   It initialises Haventec data storage for the username

   - Parameter username

   - Throws: `HaventecAuthenticateError.storageError`
   if there was an error persisting to storage.
  */
  public static func initialiseStorage(username: String) throws {
  }


  /**
   It updates Haventec data storage for the username with the JSON data

   - Parameter username

   - Throws: `HaventecAuthenticateError.jsonError`
   if there was an error parsing the Data as JSON.
   - Throws: `HaventecAuthenticateError.storageError`
   if there was an error persisting to storage.
  */
  public static func updateStorage(data: Data) throws {
  }

  /**
   It retrieves the Haventec authKey

   - Throws: `HaventecAuthenticateError.initialiseError`
   if the initialiseStorage function has not been called.

   - Returns: String Haventec authKey
   */
  public static func getAuthKey() throws -> String? {
  }

  /**
   It retrieves the Haventec JWT token

   - Throws: `HaventecAuthenticateError.initialiseError`
   if the initialiseStorage function has not been called.

   - Returns: String Haventec Authenticate JWT token
   */
  public static func getAccessToken() throws -> String? {
  }


  /**
   It retrieves the Haventec username

   - Throws: `HaventecAuthenticateError.initialiseError`
   if the initialiseStorage function has not been called.

   - Returns: String Haventec username
   */
  public static func getUsername() throws -> String? {
  }

  /**
   It retrieves the Haventec deviceUuid

   - Throws: `HaventecAuthenticateError.initialiseError`
   if the initialiseStorage function has not been called.

   - Returns: String Haventec deviceUuid
   */
  public static func getDeviceUuid() throws -> String? {
  }
}
```

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

## Installation

HaventecAuthenticate is available through [CocoaPods](https://cocoapods.org/pods/HaventecAuthenticate). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HaventecAuthenticate'
```

Afterwards, make sure to update and install the podfile in your working project directory.

## Author

Haventec - (https://www.haventec.com/)

## License

HaventecAuthenticate is available under the MIT license. See the LICENSE file for more info.
