//
//  Token.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 14/2/19.
//

import Foundation

public class Token: Decodable {
    var type: String?
    var token: String?
    
    init() {}

    init(type: String, token: String) {
        self.type = type
        self.token = token
    }
}
