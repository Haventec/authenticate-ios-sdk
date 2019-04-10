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
        do {
            let decoder = JSONDecoder()
            let thisData: HaventecData = try decoder.decode(HaventecData.self, from: data);
            
            if let thisDeviceUuid = thisData.deviceUuid, !thisDeviceUuid.isEmpty {
                haventecDataCache.deviceUuid = thisData.deviceUuid;
                try updateKeychainStorage(field: Constants.keyDeviceUuid, value: thisDeviceUuid)
            }
            
            if let thisAuthKey = thisData.authKey, !thisAuthKey.isEmpty {
                haventecDataCache.authKey = thisData.authKey;
                try updateKeychainStorage(field: Constants.keyAuthKey, value: thisAuthKey)
            }
            
            if let thisToken = thisData.accessToken, let thisHaventecDataCacheToken = haventecDataCache.accessToken {
                thisHaventecDataCacheToken.type = thisToken.type;
                thisHaventecDataCacheToken.token = thisToken.token;
                haventecDataCache.accessToken = thisHaventecDataCacheToken;
            }
            
        } catch {
            throw HaventecAuthenticate.HaventecAuthenticateError.jsonError(AuthenticateErrorCodes.jsonError.rawValue);
        }
    }
    
    public static func updateKeychainStorage(field: String, value: String) throws {
        if let username = KeychainWrapper.standard.string(forKey: Constants.keyLastUser) {
            try persist(key: field + username, value: value);
        } else {
            throw HaventecAuthenticate.HaventecAuthenticateError.initialiseError(AuthenticateErrorCodes.notInitialisedError.rawValue);
        }
    }
    
    public static func getData() -> HaventecData {
        return haventecDataCache;
    }
    
    public static func clearAccessToken() {
        return haventecDataCache.accessToken = nil;
    }
    
    private static func initialiseUserCacheData(normalisedUsername: String) throws {
        haventecDataCache = HaventecData()
        haventecDataCache.username = normalisedUsername
        haventecDataCache.deviceUuid = KeychainWrapper.standard.string(forKey: Constants.keyDeviceUuid + normalisedUsername)
        haventecDataCache.authKey = KeychainWrapper.standard.string(forKey: Constants.keyAuthKey + normalisedUsername)

        if let saltBase64Str = KeychainWrapper.standard.string(forKey: Constants.keySalt + normalisedUsername) {
            if let saltData: Data = Data(base64Encoded: saltBase64Str) {
                haventecDataCache.salt = [UInt8](saltData);
            };
        }
    }
    
    private static func initialiseUserPersistedData(normalisedUsername: String) throws {
        try persist(key: Constants.keyUsername + normalisedUsername, value: normalisedUsername);
        
        let saltOpt: String? = KeychainWrapper.standard.string(forKey: Constants.keySalt + normalisedUsername);
        

        if let salt = saltOpt {
            if ( salt.isEmpty ) {
                try persistNewSalt(normalisedUsername: normalisedUsername)
            }
        } else {
            try persistNewSalt(normalisedUsername: normalisedUsername)
        }
    }
    
    private static func persistNewSalt(normalisedUsername: String) throws {
        let salt: [UInt8] = try HaventecCommon.generateSalt();
        
        let saltBase64String = Data(salt).base64EncodedString();
        
        try persist(key: Constants.keySalt + normalisedUsername, value: saltBase64String);
    }
    
    private static func setCurrentUser(normalisedUsername: String) throws {
        try persist(key: Constants.keyLastUser, value: normalisedUsername)
    }
    
    private static func persist(key: String, value: String?) throws {
        if let value = value, !KeychainWrapper.standard.set(value, forKey: key) {
            throw HaventecAuthenticate.HaventecAuthenticateError.storageError(AuthenticateErrorCodes.notInitialisedError.rawValue);
        }
    }
}
