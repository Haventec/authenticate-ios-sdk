//
//  AutenticateErrorCodes.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 15/2/19.
//

import Foundation

enum AuthenticateErrorCodes :String { // enum with type
    case NOT_INITIALISED = "The SDK has not been initialised. Please run the initialise function"
    case HAVENTEC_COMMON = "Haventec Common Error"
    case STORAGE_ERROR = "Storage Error"
    case JSON_ERROR = "JSON Error"
}
