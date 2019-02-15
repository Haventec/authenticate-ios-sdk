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
    
    static let haventecData: HaventecData = HaventecData();
    
    public static func initialise(username: String) throws {
        
        try persist(key: "haventec_current_user", value: username);
        try persist(key: "haventec_username_" + username, value: username);

        let salt: [UInt8] = HaventecCommon.generateSalt();
        
        let saltBase64String = Data(salt).base64EncodedString();

        try persist(key: "haventec_salt_" + username, value: saltBase64String);
    }
    
    public static func updateStorage(data: Data) throws {
        do {
            let decoder = JSONDecoder()
            let thisData: HaventecData = try decoder.decode(HaventecData.self, from: data);
            
            haventecData.applicationUuid = thisData.applicationUuid;
            haventecData.username = thisData.username;
            haventecData.userUuid = thisData.userUuid;
            haventecData.deviceName = thisData.deviceName;
            haventecData.deviceUuid = thisData.deviceUuid;
            haventecData.authKey = thisData.authKey;
            
            if let thisToken = thisData.token {
                if let thisHaventecDataToken = haventecData.token {
                    thisHaventecDataToken.type = thisToken.type;
                    thisHaventecDataToken.accessToken = thisToken.accessToken;
                    haventecData.token = thisHaventecDataToken;
                }
            }
            
            try updateStorage(data: haventecData);
        } catch {
            print(error);
            preconditionFailure("Error parsing data as JSON");
        }
    }
    
    public static func updateStorage(data: HaventecData) throws {
        if let username = KeychainWrapper.standard.string(forKey: "haventec_current_user") {

            try persist(key: "haventec_applicationUuid_" + username, value: haventecData.applicationUuid);
            try persist(key: "haventec_username_" + username, value: haventecData.username);
            try persist(key: "haventec_userUuid_" + username, value: haventecData.userUuid);
            try persist(key: "haventec_deviceName_" + username, value: haventecData.deviceName);
            try persist(key: "haventec_deviceUuid_" + username, value: haventecData.deviceUuid);
            try persist(key: "haventec_authKey_" + username, value: haventecData.authKey);
            
            if let thisToken = haventecData.token {
                try persist(key: "haventec_tokenType_" + username, value: thisToken.type);
                try persist(key: "haventec_accessToken_" + username, value: thisToken.accessToken);
            }
        } else {
            throw HaventecAuthenticateError.runtimeError(AuthenticateErrorCodes.NOT_INITIALISED.rawValue);
        }
    }
    
    public static func getData() throws -> HaventecData {
        if let username = KeychainWrapper.standard.string(forKey: "haventec_current_user") {
            
            if let saltBase64Str = KeychainWrapper.standard.string(forKey: "haventec_salt_" + username) {
                if let saltData: Data = Data(base64Encoded: saltBase64Str) {
                    haventecData.salt = [UInt8](saltData);
                };
            }
            
            haventecData.applicationUuid = KeychainWrapper.standard.string(forKey: "haventec_applicationUuid_" + username);
            haventecData.username = KeychainWrapper.standard.string(forKey: "haventec_username_" + username);
            haventecData.userUuid = KeychainWrapper.standard.string(forKey: "haventec_userUuid_" + username);
            haventecData.deviceName = KeychainWrapper.standard.string(forKey: "haventec_deviceName_" + username);
            haventecData.deviceUuid = KeychainWrapper.standard.string(forKey: "haventec_deviceUuid_" + username);
            haventecData.authKey = KeychainWrapper.standard.string(forKey: "haventec_authKey_" + username);
            
            if let thisToken = haventecData.token {
                thisToken.type = KeychainWrapper.standard.string(forKey: "haventec_tokenType_" + username);
                thisToken.accessToken = KeychainWrapper.standard.string(forKey: "haventec_accessToken_" + username);
                haventecData.token = thisToken;
            }
        } else {
            throw HaventecAuthenticateError.runtimeError(AuthenticateErrorCodes.NOT_INITIALISED.rawValue);
        }
 
        return haventecData;
    }
    
    private static func persist(key: String, value: String?) throws {
        if let value = value {
            let saveSuccessful: Bool = KeychainWrapper.standard.set(value, forKey: key);
            
            if ( !saveSuccessful ) {
                throw HaventecAuthenticateError.runtimeError(AuthenticateErrorCodes.STORAGE_ERROR.rawValue);
            }
        }
    }
}
