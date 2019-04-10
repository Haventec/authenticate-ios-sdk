//
//  AutenticateErrorCodes.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 15/2/19.
//

import Foundation

public enum AuthenticateErrorCodes: String {
    case notInitialisedError = "The SDK has not been initialised. Please run the initialise function"
    case haventecCommonError = "Haventec Common Error"
    case storageError = "Storage Error"
    case jsonError = "JSON Error"
    case jwtDecodeError = "JWT Decode Error"
}
