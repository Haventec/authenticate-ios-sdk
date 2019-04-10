import XCTest
import HaventecAuthenticate
import SwiftKeychainWrapper

class HaventecAuthenticateTest: XCTestCase {
    
    let addDeviceResponseJson: String = "{\"userEmail\":\"justincrosbie@gmail.com\",\"activationToken\":\"493552\",\"deviceUuid\":\"c4acafff-f4be-4d06-b7f6-ab3f16deb50b\",\"mobileNumber\":null,\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Created\",\"code\":\"\"}}";
    let activateDeviceResponseJson: String = "{\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Changed\",\"code\":\"\"},\"authKey\":\"OX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GQ==\",\"accessToken\":{\"type\":\"JWT\",\"token\":\"eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJ0ZXN0IGFwcCIsImV4cCI6MTU0OTk0ODk2NiwiaWF0IjoxNTQ5OTQ0NDY2LCJuYmYiOjE1NDk5NDQzNDYsInN1YiI6ImpjaGFwaTE4XzIiLCJyb2xlIjpbIkhUX0FOX1VTRVIiXSwiYXBwbGljYXRpb25VVUlEIjoiYzA5ZGQ4ZWYtODIzYi00NGU1LWFhNTUtZTQ4YzM5ZjFiMzJkIiwidXNlclVVSUQiOiIzZTIzM2JiYS02NDlhLTRlMjgtYTE0ZS1kYTIyYjIxOTIyNzMiLCJqdGkiOiIyMmc1Z0Q0X3ctc2t0Z1J3V19pVm9BIn0.MSD3kQdVGsAvS3RiRJN5QOP_h6va4Ww6YdHXkS-uls4qxbqcBoTCskL06GWgA5gIY3dqakqlwd9kAYACG4QpphvP0Zu5FEc7_eDhoWE7UesrtJmB5Me8VVlPoxkpDl3t\"}}";
    let addDeviceResponseJson2: String = "{\"userEmail\":\"justincrosbie2@gmail.com\",\"activationToken\":\"493554\",\"deviceUuid\":\"c4acafff-f4be-4d06-b7f6-ab3f16deb51a\",\"mobileNumber\":null,\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Created\",\"code\":\"\"}}";
    let activateDeviceResponseJson2: String = "{\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Changed\",\"code\":\"\"},\"authKey\":\"AX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GA==\",\"accessToken\":{\"type\":\"JWT\",\"token\":\"eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJ0ZXN0IGFwcCIsImV4cCI6MTU0OTk0ODk2NiwiaWF0IjoxNTQ5OTQ0NDY2LCJuYmYiOjE1NDk5NDQzNDYsInN1YiI6ImpjaGFwaTE4XzIiLCJyb2xlIjpbIkhUX0FOX1VTRVIiXSwiYXBwbGljYXRpb25VVUlEIjoiYzA5ZGQ4ZWYtODIzYi00NGU1LWFhNTUtZTQ4YzM5ZjFiMzJkIiwidXNlclVVSUQiOiIzZTIzM2JiYS02NDlhLTRlMjgtYTE0ZS1kYTIyYjIxOTIyNzMiLCJqdGkiOiIyMmc1Z0Q0X3ctc2t0Z1J3V19pVm9BIn0.MSD3kQdVGsAvS3RiRJN5QOP_h6va4Ww6YdHXkS-uls4qxbqcBoTCskL06GWgA5gIY3dqakqlwd9kAYACG4QpphvP0Zu5FEc7_eDhoWE7UesrtJmB5Me8VVlPoxkpDl3x\"}}";

    let deviceUuid1 = "c4acafff-f4be-4d06-b7f6-ab3f16deb50b";
    let authKey1 = "OX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GQ==";
    let accessToken1 = "eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJ0ZXN0IGFwcCIsImV4cCI6MTU0OTk0ODk2NiwiaWF0IjoxNTQ5OTQ0NDY2LCJuYmYiOjE1NDk5NDQzNDYsInN1YiI6ImpjaGFwaTE4XzIiLCJyb2xlIjpbIkhUX0FOX1VTRVIiXSwiYXBwbGljYXRpb25VVUlEIjoiYzA5ZGQ4ZWYtODIzYi00NGU1LWFhNTUtZTQ4YzM5ZjFiMzJkIiwidXNlclVVSUQiOiIzZTIzM2JiYS02NDlhLTRlMjgtYTE0ZS1kYTIyYjIxOTIyNzMiLCJqdGkiOiIyMmc1Z0Q0X3ctc2t0Z1J3V19pVm9BIn0.MSD3kQdVGsAvS3RiRJN5QOP_h6va4Ww6YdHXkS-uls4qxbqcBoTCskL06GWgA5gIY3dqakqlwd9kAYACG4QpphvP0Zu5FEc7_eDhoWE7UesrtJmB5Me8VVlPoxkpDl3t";
    let deviceUuid2 = "c4acafff-f4be-4d06-b7f6-ab3f16deb51a";
    let authKey2 = "AX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GA==";
    let accessToken2 = "eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJ0ZXN0IGFwcCIsImV4cCI6MTU0OTk0ODk2NiwiaWF0IjoxNTQ5OTQ0NDY2LCJuYmYiOjE1NDk5NDQzNDYsInN1YiI6ImpjaGFwaTE4XzIiLCJyb2xlIjpbIkhUX0FOX1VTRVIiXSwiYXBwbGljYXRpb25VVUlEIjoiYzA5ZGQ4ZWYtODIzYi00NGU1LWFhNTUtZTQ4YzM5ZjFiMzJkIiwidXNlclVVSUQiOiIzZTIzM2JiYS02NDlhLTRlMjgtYTE0ZS1kYTIyYjIxOTIyNzMiLCJqdGkiOiIyMmc1Z0Q0X3ctc2t0Z1J3V19pVm9BIn0.MSD3kQdVGsAvS3RiRJN5QOP_h6va4Ww6YdHXkS-uls4qxbqcBoTCskL06GWgA5gIY3dqakqlwd9kAYACG4QpphvP0Zu5FEc7_eDhoWE7UesrtJmB5Me8VVlPoxkpDl3x";

    let badJson = "uh-oh";
    
    let exceptionThrown = "Haventec Exception was thrown from this call"
    
    let username1 = "testuser1"
    let username2 = "testuser2"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        destroyTestKeychainData()

        do {
            try HaventecAuthenticate.initialiseStorage(username: "")
        } catch {
            XCTFail()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        destroyTestKeychainData()
    }
    
    func testInitialiseStorage() throws {
        
        var thisUsername: String? = try HaventecAuthenticate.getUsername()

        XCTAssertEqual(thisUsername, "")

        try HaventecAuthenticate.initialiseStorage(username: username1)
        
        thisUsername = try HaventecAuthenticate.getUsername()
        
        XCTAssertEqual(thisUsername, username1)
    }

    func testHashPin_AlwaysProducesSameHashForPIN() throws {
        
        try HaventecAuthenticate.initialiseStorage(username: username1)

        let hashPIN1 = try HaventecAuthenticate.hashPin(pin: "1234")
        let hashPIN2 = try HaventecAuthenticate.hashPin(pin: "1234")

        XCTAssertEqual(hashPIN1, hashPIN2)
        
        try HaventecAuthenticate.initialiseStorage(username: username1)
        
        let hashPIN3 = try HaventecAuthenticate.hashPin(pin: "1234")

        XCTAssertEqual(hashPIN1, hashPIN3)
        
        try HaventecAuthenticate.initialiseStorage(username: username2)
        
        let hashPIN4 = try HaventecAuthenticate.hashPin(pin: "1234")

        XCTAssertNotEqual(hashPIN1, hashPIN4)
        
        try HaventecAuthenticate.initialiseStorage(username: username1)
        
        let hashPIN5 = try HaventecAuthenticate.hashPin(pin: "1234")
        
        XCTAssertEqual(hashPIN1, hashPIN5)
    }
    

    func testUpdateStorage() throws {
        try HaventecAuthenticate.initialiseStorage(username: username1)
        
        var thisUsername: String? = try HaventecAuthenticate.getUsername()
        var thisDeviceUuid: String? = try HaventecAuthenticate.getDeviceUuid()
        var thisAuthKey: String? = try HaventecAuthenticate.getAuthKey()
        var thisAccessToken: String? = try HaventecAuthenticate.getAccessToken()
        
        XCTAssertEqual(username1, thisUsername)
        XCTAssertNil(thisDeviceUuid)
        XCTAssertNil(thisAuthKey)
        XCTAssertNil(thisAccessToken)
        
        let addDeviceResponseJsonData = addDeviceResponseJson.data(using: .utf8)!
        try HaventecAuthenticate.updateStorage(data: addDeviceResponseJsonData)
        
        thisUsername = try HaventecAuthenticate.getUsername()
        thisDeviceUuid = try HaventecAuthenticate.getDeviceUuid()
        thisAuthKey = try HaventecAuthenticate.getAuthKey()
        thisAccessToken = try HaventecAuthenticate.getAccessToken()
        
        XCTAssertEqual(username1, thisUsername)
        XCTAssertEqual(deviceUuid1, thisDeviceUuid)
        XCTAssertNil(thisAuthKey)
        XCTAssertNil(thisAccessToken)
        
        let activateDeviceResponseJsonData = activateDeviceResponseJson.data(using: .utf8)!
        try HaventecAuthenticate.updateStorage(data: activateDeviceResponseJsonData)
        
        thisUsername = try HaventecAuthenticate.getUsername()
        thisDeviceUuid = try HaventecAuthenticate.getDeviceUuid()
        thisAuthKey = try HaventecAuthenticate.getAuthKey()
        thisAccessToken = try HaventecAuthenticate.getAccessToken()
        
        XCTAssertEqual(username1, thisUsername)
        XCTAssertEqual(deviceUuid1, thisDeviceUuid)
        XCTAssertEqual(authKey1, thisAuthKey)
        XCTAssertEqual(accessToken1, thisAccessToken)
    }
    
    func testUpdateStorage_Fail_Bad_Json() throws {
        try HaventecAuthenticate.initialiseStorage(username: username1)
        
        let addDeviceResponseJsonData = badJson.data(using: .utf8)!
        do {
            try HaventecAuthenticate.updateStorage(data: addDeviceResponseJsonData)
            XCTFail("haventecAuthenticate.jsonError expected")
        } catch HaventecAuthenticate.HaventecAuthenticateError.jsonError(let errorMsg) {
            XCTAssertEqual(AuthenticateErrorCodes.jsonError.rawValue, errorMsg)
        }
        
        let thisDeviceUuid: String? = try HaventecAuthenticate.getDeviceUuid()
        
        XCTAssertNil(thisDeviceUuid);
    }
    
    func testTwoUsersSwitch() throws {

        //
        // First, test that values get set appropriately for username1
        //
        
        try HaventecAuthenticate.initialiseStorage(username: username1)
        
        var firstUsername: String? = try HaventecAuthenticate.getUsername()
        var firstDeviceUuid: String? = try HaventecAuthenticate.getDeviceUuid()
        var firstAuthKey: String? = try HaventecAuthenticate.getAuthKey()
        var firstAccessToken: String? = try HaventecAuthenticate.getAccessToken()

        XCTAssertEqual(username1, firstUsername)
        XCTAssertNil(firstDeviceUuid)
        XCTAssertNil(firstAuthKey)
        XCTAssertNil(firstAccessToken)

        let addDeviceResponseJsonData = addDeviceResponseJson.data(using: .utf8)!
        try HaventecAuthenticate.updateStorage(data: addDeviceResponseJsonData)
        let activateDeviceResponseJsonData = activateDeviceResponseJson.data(using: .utf8)!
        try HaventecAuthenticate.updateStorage(data: activateDeviceResponseJsonData)

        firstUsername = try HaventecAuthenticate.getUsername()
        firstDeviceUuid = try HaventecAuthenticate.getDeviceUuid()
        firstAuthKey = try HaventecAuthenticate.getAuthKey()
        firstAccessToken = try HaventecAuthenticate.getAccessToken()
        
        XCTAssertEqual(username1, firstUsername)
        XCTAssertEqual(deviceUuid1, firstDeviceUuid)
        XCTAssertEqual(authKey1, firstAuthKey)
        XCTAssertEqual(accessToken1, firstAccessToken)

        
        //
        // Now test onboarding a second user
        //
        
        try HaventecAuthenticate.initialiseStorage(username: username2);
        
        var secondUsername: String? = try HaventecAuthenticate.getUsername()
        var secondDeviceUuid: String? = try HaventecAuthenticate.getDeviceUuid()
        var secondAuthKey: String? = try HaventecAuthenticate.getAuthKey()
        var secondAccessToken: String? = try HaventecAuthenticate.getAccessToken()
        
        XCTAssertEqual(username2, secondUsername)
        XCTAssertNil(secondDeviceUuid)
        XCTAssertNil(secondAuthKey)
        XCTAssertNil(secondAccessToken)
        
        let addDeviceResponseJsonData2 = addDeviceResponseJson2.data(using: .utf8)!
        try HaventecAuthenticate.updateStorage(data: addDeviceResponseJsonData2);
        let activateDeviceResponseJsonData2 = activateDeviceResponseJson2.data(using: .utf8)!
        try HaventecAuthenticate.updateStorage(data: activateDeviceResponseJsonData2)
        
        secondUsername = try HaventecAuthenticate.getUsername()
        secondDeviceUuid = try HaventecAuthenticate.getDeviceUuid()
        secondAuthKey = try HaventecAuthenticate.getAuthKey()
        secondAccessToken = try HaventecAuthenticate.getAccessToken()
        
        XCTAssertEqual(username2, secondUsername)
        XCTAssertEqual(deviceUuid2, secondDeviceUuid)
        XCTAssertEqual(authKey2, secondAuthKey)
        XCTAssertEqual(accessToken2, secondAccessToken)

        //
        // Now test that switching back to the first user retains the context, so we haven't lost any data
        //
        
        try HaventecAuthenticate.initialiseStorage(username: username1);
        
        try XCTAssertEqual(username1, HaventecAuthenticate.getUsername())
        try XCTAssertEqual(firstDeviceUuid, HaventecAuthenticate.getDeviceUuid())
        try XCTAssertEqual(firstAuthKey, HaventecAuthenticate.getAuthKey())
        try XCTAssertNil(HaventecAuthenticate.getAccessToken())
    }
    
    
    
    func destroyTestKeychainData() {
        var removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: username1)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_username_" + username1)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_salt_" + username1)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_deviceUuid_" + username1)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_authKey_" + username1)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_tokenType_" + username1)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_accessToken_" + username1)
        
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: username2)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_username_" + username2)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_salt_" + username2)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_deviceUuid_" + username2)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_authKey_" + username2)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_tokenType_" + username2)
        removeSuccessful = KeychainWrapper.standard.removeObject(forKey: "haventec_accessToken_" + username2)
    }
}
