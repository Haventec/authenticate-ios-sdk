//
//  StorageHelper.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 13/2/19.
//

import Foundation
import SwiftKeychainWrapper
import HaventecCommon

public class StorageHelper {
    
    static var haventecDataCache: HaventecData = HaventecData();
    
    public static func initialise(username: String) throws {
        let normalisedUsername = username.lowercased()
        
        try setCurrentUser(normalisedUsername: normalisedUsername)
        
        try initialiseUserPersistedData(normalisedUsername: normalisedUsername)
        
        try initialiseUserCacheData(normalisedUsername: normalisedUsername)
    }
    
    public static func updateStorage(data: Data) throws {
        guard let jsonObject = try? JSONDecoder().decode(HaventecData.self, from: data) else {
            throw HaventecAuthenticateError.jsonError(ErrorMessage.invalidJSONObject.rawValue)
        }
        
        do {
            if let deviceUuid = jsonObject.deviceUuid, !deviceUuid.isEmpty {
                try updateKeychainStorage(field: Constants.keyDeviceUuid, value: deviceUuid)
                haventecDataCache.deviceUuid = deviceUuid
            }
            
            if let authKey = jsonObject.authKey, !authKey.isEmpty {
                try updateKeychainStorage(field: Constants.keyAuthKey, value: authKey)
                haventecDataCache.authKey = authKey
            }
            
            if let accessToken = jsonObject.accessToken {
                haventecDataCache.accessToken = accessToken
            }
        } catch {
            throw HaventecAuthenticateError.jsonError(ErrorMessage.failedKeyChainUpdate.rawValue)
        }
    }
    
    public static func updateKeychainStorage(field: String, value: String) throws {
        if let username = KeychainWrapper.standard.string(forKey: Constants.keyLastUser) {
            try persist(key: field + username, value: value)
        } else {
            throw HaventecAuthenticateError.initialiseError(ErrorMessage.uninitialisedSDK.rawValue)
        }
    }
    
    public static func getData() -> HaventecData {
        return haventecDataCache
    }
    
    public static func getSalt() throws -> [UInt8] {
        if let salt = haventecDataCache.salt {
            return salt
        } else {
            throw HaventecAuthenticateError.initialiseError(ErrorMessage.uninitialisedSDK.rawValue)
        }
    }
    
    public static func getAccessToken() throws -> String? {
        if let accessToken = haventecDataCache.accessToken {
            return accessToken.token
        } else {
            throw HaventecAuthenticateError.initialiseError(ErrorMessage.noAccessTokenInKeyChain.rawValue)
        }
    }
    
    public static func clearAccessToken() {
        haventecDataCache.accessToken = nil
    }
    
    public static func getCurrentUserUuid() throws -> String? {
        if let accessToken = haventecDataCache.accessToken, let value = accessToken.token {
            return try TokenHelper.getUserUuidFromJWT(jwtToken: value)
        } else {
            throw HaventecAuthenticateError.storageError(ErrorMessage.noAccessTokenInKeyChain.rawValue)
        }
    }
    
    public static func getDeviceUuid() throws -> String {
        if let deviceUuid = haventecDataCache.deviceUuid {
            return deviceUuid
        } else {
            throw HaventecAuthenticateError.storageError(ErrorMessage.uninitialisedSDK.rawValue)
        }
    }
    
    private static func initialiseUserCacheData(normalisedUsername: String) throws {
        guard let salt = KeychainWrapper.standard.string(forKey: Constants.keySalt + normalisedUsername) else {
            throw HaventecAuthenticateError.storageError(ErrorMessage.noSaltInKeyChain.rawValue)
        }
        
        haventecDataCache = HaventecData()
        haventecDataCache.username = normalisedUsername
        haventecDataCache.deviceUuid = KeychainWrapper.standard.string(forKey: Constants.keyDeviceUuid + normalisedUsername)
        haventecDataCache.authKey = KeychainWrapper.standard.string(forKey: Constants.keyAuthKey + normalisedUsername)
        haventecDataCache.salt = Data(base64Encoded: salt)?.bytes
    }
    
    private static func initialiseUserPersistedData(normalisedUsername: String) throws {
        try persist(key: Constants.keyUsername + normalisedUsername, value: normalisedUsername)
        
        let saltOpt: String? = KeychainWrapper.standard.string(forKey: Constants.keySalt + normalisedUsername)
        
        guard let salt = saltOpt else { try persistNewSalt(normalisedUsername: normalisedUsername); return }
        
        if (!salt.isEmpty) {
            return
        }
        
        try persistNewSalt(normalisedUsername: normalisedUsername)
    }
    
    private static func persistNewSalt(normalisedUsername: String) throws {
        let salt: [UInt8] = try HaventecCommon.generateSalt()
        
        let saltBase64String = Data(salt).base64EncodedString()
        
        try persist(key: Constants.keySalt + normalisedUsername, value: saltBase64String)
    }
    
    private static func setCurrentUser(normalisedUsername: String) throws {
        try persist(key: Constants.keyLastUser, value: normalisedUsername)
    }
    
    private static func persist(key: String, value: String?) throws {
        guard let value = value else {
            throw HaventecAuthenticateError.storageError(ErrorMessage.uninitialisedSDK.rawValue)
        }
        
        if !KeychainWrapper.standard.set(value, forKey: key) {
            throw HaventecAuthenticateError.storageError(ErrorMessage.failedKeyChainUpdate.rawValue)
        }
    }
}
