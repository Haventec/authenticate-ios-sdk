//
//  AutenticateErrorCodes.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 15/2/19.
//

import Foundation

public enum HaventecAuthenticateError: Error {
    case invalidJwt(String)
    case uninitialisedStorage(String)
    case invalidData(String)
    case invalidStorageKey(String)
    case uninitialisedStorageKey(String)
    case initialisedStorage(String)
    case invalidUpdate(String)
}

public enum ErrorMessage: String {
    case invalidJSONObject = "Unable to decode and deserialize the data given into a JSON object"
    case failedKeyChainUpdate = "Error updating the KeyChain with the keys given"
    case uninitialisedSDK = "The SDK has not been initialised. Please run the initialise function"
    case noAccessTokenInKeyChain = "No access token set"
    case noSaltInKeyChain = "No salt value set in the keyChain for the given user"
}


