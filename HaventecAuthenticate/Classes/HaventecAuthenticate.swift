import Foundation
import CommonCrypto

public class HaventecAuthenticate {
    
    enum HaventecAuthenticateException: Error {
        case generateSalt(String)
        case hashPin(String)
    }
    
    public static func initialiseStorage(username: String) {}
    
    public static func updateStorage(username: String) {}
    
    public static func getDeviceName() {}
    
    public static func clearAccessToken() {}
    
    public static func getAccessToken() {}
    
    public static func getUsername() {}
    
    public static func getDeviceUuid() {}
    
    public static func getUserUuid() {}
    
    public static func getAuthKey() {}
    
    public static func getConfiguredUsernames() {}
    
    public static func clearUserStorage(username: String) {}
}
