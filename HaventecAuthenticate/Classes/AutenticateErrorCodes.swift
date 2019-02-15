//
//  AutenticateErrorCodes.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 15/2/19.
//

import Foundation

public enum AuthenticateErrorCodes :String {
    case not_initialised_error = "The SDK has not been initialised. Please run the initialise function"
    case haventec_common_error = "Haventec Common Error"
    case storage_error = "Storage Error"
    case json_error = "JSON Error"
}
