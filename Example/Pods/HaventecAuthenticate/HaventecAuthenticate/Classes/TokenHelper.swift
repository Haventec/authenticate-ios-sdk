//
//  TokenHelper.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 18/3/19.
//

import Foundation
import JWTDecode

public class TokenHelper {
    
    public static func getUserUuidFromJWT(jwtToken: String) throws -> String? {
        if let token = try? decode(jwt: jwtToken) {
            return token.claim(name: "userUUID").string
        } else {
            throw HaventecAuthenticateError.jwtError(AuthenticateErrorCodes.invalidJWT.rawValue)
        }
    }
}
