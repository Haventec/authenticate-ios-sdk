import Foundation
import HaventecCommon


public class HaventecAuthenticate {
    
    public static func hashPin(pin: String) throws -> String? {
        
        if let salt = try StorageHelper.getData().salt {
            return HaventecCommon.hashPin(saltBytes: salt, pin: pin);
        } else {
            throw HaventecAuthenticateError.runtimeError(AuthenticateErrorCodes.NOT_INITIALISED.rawValue);
        }
    }
    
    public static func initialiseStorage(username: String) throws {
        try StorageHelper.initialise(username: username);
    }
    
    public static func updateStorage(data: Data) throws {
        try StorageHelper.updateStorage(data: data);
    }
    
    public static func getDeviceName() throws -> String? {
        return try StorageHelper.getData().deviceName;
    }
    
    public static func getAccessToken() throws -> String? {
        if let thisToken = try StorageHelper.getData().token {
            return thisToken.accessToken;
        } else {
            throw HaventecAuthenticateError.runtimeError(AuthenticateErrorCodes.NOT_INITIALISED.rawValue);
        }
    }
    public static func getUsername() throws -> String? {
        return try StorageHelper.getData().username;
    }
    
    public static func getDeviceUuid() throws -> String? {
        return try StorageHelper.getData().deviceUuid;
    }
    public static func getUserUuid() throws -> String? {
        return try StorageHelper.getData().userUuid;
    }
    public static func getAuthKey() throws -> String? {
        return try StorageHelper.getData().authKey;
    }
}
