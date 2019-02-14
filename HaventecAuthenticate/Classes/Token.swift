//
//  Token.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 14/2/19.
//

import Foundation

public class Token : Decodable {
    var type: String?;
    var accessToken: String?;
    
    init() {
        self.type = nil;
        self.accessToken = nil;
    }

    init(type: String, accessToken: String) {
        self.type = type;
        self.accessToken = accessToken;
    }
}
