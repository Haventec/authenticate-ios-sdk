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
            
            if let thisDeviceUuid = thisData.deviceUuid {
                if ( !thisDeviceUuid.isEmpty ) {
                    haventecDataCache.deviceUuid = thisData.deviceUuid;
                    try updateKeychainStorage(field: Constants.KEY_DEVICEUUID, value: thisDeviceUuid)
                }
            }
            
            if let thisAuthKey = thisData.authKey {
                if ( !thisAuthKey.isEmpty ) {
                    haventecDataCache.authKey = thisData.authKey;
                    try updateKeychainStorage(field: Constants.KEY_AUTHKEY, value: thisAuthKey)
                }
            }
            
            if let thisToken = thisData.accessToken {
                if let thisHaventecDataCacheToken = haventecDataCache.accessToken {
                    thisHaventecDataCacheToken.type = thisToken.type;
                    thisHaventecDataCacheToken.token = thisToken.token;
                    haventecDataCache.accessToken = thisHaventecDataCacheToken;
                }
            }
            
        } catch {
            throw HaventecAuthenticate.HaventecAuthenticateError.jsonError(AuthenticateErrorCodes.json_error.rawValue);
        }
    }
    
    public static func updateKeychainStorage(field: String, value: String) throws {
        if let username = KeychainWrapper.standard.string(forKey: Constants.KEY_LAST_USER) {
            try persist(key: field + username, value: value);
        } else {
            throw HaventecAuthenticate.HaventecAuthenticateError.initialiseError(AuthenticateErrorCodes.not_initialised_error.rawValue);
        }
    }
    
    public static func getData() -> HaventecData {
        return haventecDataCache;
    }
    
    private static func initialiseUserCacheData(normalisedUsername: String) throws {
        haventecDataCache = HaventecData()
        haventecDataCache.username = normalisedUsername
        haventecDataCache.deviceUuid = KeychainWrapper.standard.string(forKey: Constants.KEY_DEVICEUUID + normalisedUsername)
        haventecDataCache.authKey = KeychainWrapper.standard.string(forKey: Constants.KEY_AUTHKEY + normalisedUsername)

        if let saltBase64Str = KeychainWrapper.standard.string(forKey: Constants.KEY_SALT + normalisedUsername) {
            if let saltData: Data = Data(base64Encoded: saltBase64Str) {
                haventecDataCache.salt = [UInt8](saltData);
            };
        }
    }
    
    private static func initialiseUserPersistedData(normalisedUsername: String) throws {

        try persist(key: Constants.KEY_USERNAME + normalisedUsername, value: normalisedUsername);
        
        let saltOpt: String? = KeychainWrapper.standard.string(forKey: Constants.KEY_SALT + normalisedUsername);

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
        
        try persist(key: Constants.KEY_SALT + normalisedUsername, value: saltBase64String);
    }
    
    private static func setCurrentUser(normalisedUsername: String) throws {
        try persist(key: Constants.KEY_LAST_USER, value: normalisedUsername)
    }
    
    private static func persist(key: String, value: String?) throws {
        if let value = value {
            let saveSuccessful: Bool = KeychainWrapper.standard.set(value, forKey: key);
            
            if ( !saveSuccessful ) {
                throw HaventecAuthenticate.HaventecAuthenticateError.storageError(AuthenticateErrorCodes.not_initialised_error.rawValue);
            }
        }
    }
}
