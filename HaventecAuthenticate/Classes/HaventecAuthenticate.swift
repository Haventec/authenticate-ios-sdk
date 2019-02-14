import Foundation

public class HaventecAuthenticate {
    
    public static func initialiseStorage(username: String) {
        StorageHelper.initialise(username: username);
    }
    
    public static func updateStorage(data: Data) {
        StorageHelper.updateStorage(data: data);
    }
    
    public static func getDeviceName() -> String? {
        return StorageHelper.getData().deviceName;
    }
    
    public static func getAccessToken() -> String? {
        if let thisToken = StorageHelper.getData().token {
            return thisToken.accessToken;
        }
        
        return nil;
    }
    public static func getUsername() -> String? {
        return StorageHelper.getData().username;
    }
    
    public static func getDeviceUuid() -> String? {
        return StorageHelper.getData().deviceUuid;
    }
    public static func getUserUuid() -> String? {
        return StorageHelper.getData().userUuid;
    }
    public static func getAuthKey() -> String? {
        return StorageHelper.getData().authKey;
    }
}
