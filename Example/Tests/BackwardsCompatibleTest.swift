//
//  BackwardsCompatibleTest.swift
//  HaventecAuthenticate_Tests
//
//  Created by Clifford Phan on 3/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

import XCTest
import HaventecAuthenticate
import SwiftKeychainWrapper

class BackwardsCompatibleTest: XCTestCase {
    /// Hard Coded values of keychain from previous version for hash
    let username: String = "jchapi18_2"
    let deviceUuid: String = "98efb8f8-6957-4dc7-b1d3-b97a832651b1"
    
    let pin: String = "1234"
    let saltBytes: [UInt8] = [73, 81, 91, 116, 94, 12, 15, 13, 90, 48, 3, 86, 30, 109, 19, 20, 91, 60, 59, 0, 18, 57, 112, 126, 93, 87, 107, 126, 84, 69, 70, 19, 98, 114, 112, 6, 4, 105, 74, 62, 112, 75, 124, 7, 125, 120, 89, 110, 105, 67, 113, 1, 68, 4, 115, 126, 114, 90, 121, 31, 55, 11, 47, 45, 104, 122, 80, 56, 47, 107, 22, 1, 114, 123, 40, 3, 82, 32, 90, 88, 21, 60, 41, 63, 47, 7, 41, 39, 124, 60, 6, 59, 94, 75, 116, 104, 52, 24, 12, 84, 52, 58, 65, 6, 45, 99, 49, 69, 78, 107, 27, 31, 16, 83, 6, 35, 10, 31, 116, 95, 18, 92, 23, 91, 102, 48, 6, 104]
    let hashedPin = "C4unZffiBl11PBpMVaFEPGCNlq1yFVmznnC1H2qTH9vBdZquvwT70KvNufWw554QLUo+j9E0j/uV9Vd/qDdgVg=="
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testHashPin() {
        guard let currenthashedPin = try? HaventecAuthenticate.hashPin(pin: pin) else { XCTFail(); return }
        
        XCTAssertEqual(currenthashedPin, hashedPin)
    }
}
