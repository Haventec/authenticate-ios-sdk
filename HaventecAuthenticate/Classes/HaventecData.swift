//
//  HaventecData.swift
//  HaventecAuthenticate
//
//  Created by Justin Crosbie on 14/2/19.
//

import Foundation

public class HaventecData: Decodable {

    var salt: [UInt8]?;
    var username: String?;
    var deviceUuid: String?;
    var authKey: String?;
    var accessToken: Token?;

    init() {
        self.salt = nil;
        self.username = nil;
        self.deviceUuid = nil;
        self.authKey = nil;
        self.accessToken = Token();
    }
}
