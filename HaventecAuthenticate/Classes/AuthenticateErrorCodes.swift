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
