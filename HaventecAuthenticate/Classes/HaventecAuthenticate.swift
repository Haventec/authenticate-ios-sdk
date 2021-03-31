import Foundation
import HaventecCommon

public class HaventecAuthenticate {
    /**
     It creates a Hash of the pin, along with the salt that is in Storage
     
     - Parameter pin: The PIN code.
     
     - Throws: `HaventecAuthenticateError.initialiseError`
     if the initialiseStorage function has not been called.

     - Returns: String Base64-encoded representation of the SHA-512 hashed `pin` and stored salt.
    */
    public static func hashPin(pin: String) throws -> String? {
        if let saltBytes = StorageHelper.getData().salt {
            return try HaventecCommon.hashPin(saltBytes: saltBytes, pin: pin);
        } else {
            throw HaventecAuthenticateError.initialiseError(AuthenticateErrorCodes.uninitialisedSDK.rawValue)
        }
    }

    /**
     It initialises Haventec data storage for the username
     
     - Parameter username
     
     - Throws: `HaventecAuthenticateError.storageError`
     if there was an error persisting to storage.
    */
    public static func initialiseStorage(username: String) throws {
        try StorageHelper.initialise(username: username);
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
        try StorageHelper.updateStorage(data: data);
    }
    
    /**
     It updates Haventec data storage for the username with the JSON data
     
     - Parameter username
     
     - Throws: `HaventecAuthenticateError.jsonError`
     if there was an error parsing the Data as JSON.
     - Throws: `HaventecAuthenticateError.storageError`
     if there was an error persisting to storage.
    */
    public static func regenerateSalt(username: String) throws {
        try StorageHelper.regenerateSalt(username: username);
    }
    
    /**
     It retrieves the Haventec authKey
     
     - Returns: String Haventec authKey
     */
    public static func getAuthKey() -> String? {
        return StorageHelper.getData().authKey;
    }

    /**
     It retrieves the Haventec JWT token
     
     - Returns: String Haventec Authenticate JWT token
     */
    public static func getAccessToken() throws -> String? {
        return try StorageHelper.getAccessToken()
    }
    
    /**
     It nulls the JWT accessToken data. This can be executed as part of a logout user flow,
     to ensure no further transactions can be executed.
     A subsequent updateStorage invocation on the response of a successful login will update the data.
     */
    public static func clearAccessToken() {
        StorageHelper.clearAccessToken()
    }
    

    /**
     It retrieves the Haventec userUuid from the current accessToken
     
     - Returns: String Haventec userUuid
     */
    public static func getUserUuid() throws -> String? {
        return try StorageHelper.getCurrentUserUuid()
    }
    
    /**
     It retrieves the Haventec username
     
     - Returns: String Haventec username
     */
    public static func getUsername() -> String? {
        return StorageHelper.getData().username;
    }
    
    /**
     It retrieves the Haventec deviceUuid
     
     - Returns: String Haventec deviceUuid
     */
    public static func getDeviceUuid() -> String? {
        return StorageHelper.getData().deviceUuid
    }
    
    /**
     It retrieves the device name, as defined by the UIDevice.current.name value.
     
     - Returns: String Haventec device name
     */
    public static func getDeviceName() -> String {
        return DeviceHelper.getDeviceName()
    }
}
