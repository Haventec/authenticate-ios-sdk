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
        return try decode(jwt: jwtToken).claim(name: "userUUID").string
    }
}
