import XCTest
import HaventecAuthenticate
import SwiftKeychainWrapper

class HaventecAuthenticateTest: XCTestCase {
    
    let addDeviceResponseJson: String = "{\"userEmail\":\"justincrosbie@gmail.com\",\"activationToken\":\"493552\",\"deviceUuid\":\"c4acafff-f4be-4d06-b7f6-ab3f16deb50b\",\"mobileNumber\":null,\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Created\",\"code\":\"\"}}";
    let activateDeviceResponseJson: String = "{\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Changed\",\"code\":\"\"},\"authKey\":\"OX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GQ==\",\"accessToken\":{\"type\":\"JWT\",\"token\":\"eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJ0ZXN0IGFwcCIsImV4cCI6MTU0OTk0ODk2NiwiaWF0IjoxNTQ5OTQ0NDY2LCJuYmYiOjE1NDk5NDQzNDYsInN1YiI6ImpjaGFwaTE4XzIiLCJyb2xlIjpbIkhUX0FOX1VTRVIiXSwiYXBwbGljYXRpb25VVUlEIjoiYzA5ZGQ4ZWYtODIzYi00NGU1LWFhNTUtZTQ4YzM5ZjFiMzJkIiwidXNlclVVSUQiOiIzZTIzM2JiYS02NDlhLTRlMjgtYTE0ZS1kYTIyYjIxOTIyNzMiLCJqdGkiOiIyMmc1Z0Q0X3ctc2t0Z1J3V19pVm9BIn0.MSD3kQdVGsAvS3RiRJN5QOP_h6va4Ww6YdHXkS-uls4qxbqcBoTCskL06GWgA5gIY3dqakqlwd9kAYACG4QpphvP0Zu5FEc7_eDhoWE7UesrtJmB5Me8VVlPoxkpDl3t\"}}";
    let addDeviceResponseJson2: String = "{\"userEmail\":\"justincrosbie2@gmail.com\",\"activationToken\":\"493554\",\"deviceUuid\":\"c4acafff-f4be-4d06-b7f6-ab3f16deb51a\",\"mobileNumber\":null,\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Created\",\"code\":\"\"}}";
    let activateDeviceResponseJson2: String = "{\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Changed\",\"code\":\"\"},\"authKey\":\"AX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GA==\",\"accessToken\":{\"type\":\"JWT\",\"token\":\"eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJIYXZlbnRlYyIsImV4cCI6MTU1MjYyMjA3NywiaWF0IjoxNTUyNjE4NDc3LCJuYmYiOjE1NTI2MTgzNTcsInN1YiI6ImFkbWluIiwicm9sZSI6WyJIVF9BRE1JTiJdLCJhcHBsaWNhdGlvblVVSUQiOiI0ZGRlMmNlNS1iYzY4LTRhNmUtOGQyYS1jNzZkNzY5NTM4MWYiLCJ1c2VyVVVJRCI6ImVhYmJlNDBlLWM0NWMtNGI1NS1iYjM2LWNkN2QwZmMwNjcxYyIsImp0aSI6Ii1OZXU1US01MmFyXzhBXzcwcUZibmcifQ.wtgpkjqt-yNdXASu6iWo-oZSqIlN_D_ALRDCNY5APhOCEqlLNmPh8lBi56gr_6s9zfWHzKPo-wF_3vV-SfyLMPGUmIPpefDYNDoaVhmfvbElvFveRR1btIjGq_5zKMyt\"}}";

    let deviceUuid1 = "c4acafff-f4be-4d06-b7f6-ab3f16deb50b";
    let authKey1 = "OX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GQ==";
    let accessToken1 = "eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJ0ZXN0IGFwcCIsImV4cCI6MTU0OTk0ODk2NiwiaWF0IjoxNTQ5OTQ0NDY2LCJuYmYiOjE1NDk5NDQzNDYsInN1YiI6ImpjaGFwaTE4XzIiLCJyb2xlIjpbIkhUX0FOX1VTRVIiXSwiYXBwbGljYXRpb25VVUlEIjoiYzA5ZGQ4ZWYtODIzYi00NGU1LWFhNTUtZTQ4YzM5ZjFiMzJkIiwidXNlclVVSUQiOiIzZTIzM2JiYS02NDlhLTRlMjgtYTE0ZS1kYTIyYjIxOTIyNzMiLCJqdGkiOiIyMmc1Z0Q0X3ctc2t0Z1J3V19pVm9BIn0.MSD3kQdVGsAvS3RiRJN5QOP_h6va4Ww6YdHXkS-uls4qxbqcBoTCskL06GWgA5gIY3dqakqlwd9kAYACG4QpphvP0Zu5FEc7_eDhoWE7UesrtJmB5Me8VVlPoxkpDl3t";
    let deviceUuid2 = "c4acafff-f4be-4d06-b7f6-ab3f16deb51a";
    let authKey2 = "AX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GA==";
    let accessToken2 = "eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJIYXZlbnRlYyIsImV4cCI6MTU1MjYyMjA3NywiaWF0IjoxNTUyNjE4NDc3LCJuYmYiOjE1NTI2MTgzNTcsInN1YiI6ImFkbWluIiwicm9sZSI6WyJIVF9BRE1JTiJdLCJhcHBsaWNhdGlvblVVSUQiOiI0ZGRlMmNlNS1iYzY4LTRhNmUtOGQyYS1jNzZkNzY5NTM4MWYiLCJ1c2VyVVVJRCI6ImVhYmJlNDBlLWM0NWMtNGI1NS1iYjM2LWNkN2QwZmMwNjcxYyIsImp0aSI6Ii1OZXU1US01MmFyXzhBXzcwcUZibmcifQ.wtgpkjqt-yNdXASu6iWo-oZSqIlN_D_ALRDCNY5APhOCEqlLNmPh8lBi56gr_6s9zfWHzKPo-wF_3vV-SfyLMPGUmIPpefDYNDoaVhmfvbElvFveRR1btIjGq_5zKMyt";

    let userUuid1 = "3e233bba-649a-4e28-a14e-da22b2192273";
    let userUuid2 = "eabbe40e-c45c-4b55-bb36-cd7d0fc0671c";
    let invalidJsonResponse = "uh-oh";
    
    let exceptionThrown = "Haventec Exception was thrown from this call"
    
    let username1 = "testuser1"
    let username2 = "testuser2"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        KeychainWrapper.standard.removeAllKeys()
        guard (try? HaventecAuthenticate.initialiseStorage(username: "")) != nil else { XCTFail(); return }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        KeychainWrapper.standard.removeAllKeys()
    }
    
    func testInitialiseStorage_success() throws {
        // Test user initialised from setup
        XCTAssertNotNil(HaventecAuthenticate.getDeviceName())
        assertAgainstUsername(username: "")
        
        // Initialise to new user
        try HaventecAuthenticate.initialiseStorage(username: username1)
        XCTAssertNotNil(HaventecAuthenticate.getDeviceName())
        assertAgainstUsername(username: username1)
        
        // Initialise to new user
        try HaventecAuthenticate.initialiseStorage(username: username2)
        XCTAssertNotNil(HaventecAuthenticate.getDeviceName())
        assertAgainstUsername(username: username2)
    }

    func testClearAccessToken_success() throws {
        try HaventecAuthenticate.initialiseStorage(username: username1)
        try HaventecAuthenticate.updateStorage(data: addDeviceResponseJson.data(using: .utf8)!)
        try HaventecAuthenticate.updateStorage(data: activateDeviceResponseJson.data(using: .utf8)!)
        
        // Check optionals and throws and values
        assertAgainstUsername(username: username1)
        assertAgainstDeviceUuid(deviceUuid: deviceUuid1)
        assertAgainstAuthKey(authKey: authKey1)
        assertAgainstAccessToken(accessToken: accessToken1)
        assertAgainstUserUuid(userUuid: userUuid1)

        let deviceName = HaventecAuthenticate.getDeviceName()
        XCTAssertNotNil(deviceName)

        HaventecAuthenticate.clearAccessToken()
        
        assertAgainstUsername(username: username1)
        assertAgainstDeviceUuid(deviceUuid: deviceUuid1)
        assertAgainstAuthKey(authKey: authKey1)

        XCTAssertEqual(deviceName, HaventecAuthenticate.getDeviceName())
        
        // Shoudl throw errors since the access token is nil
        XCTAssertThrowsError(try HaventecAuthenticate.getAccessToken())
        XCTAssertThrowsError(try HaventecAuthenticate.getUserUuid())
    }

    func testHashPin_sameHashWithSamePin() throws {
        try HaventecAuthenticate.initialiseStorage(username: username1)

        let hashPIN1 = try HaventecAuthenticate.hashPin(pin: "1234")
        let hashPIN2 = try HaventecAuthenticate.hashPin(pin: "1234")

        XCTAssertEqual(hashPIN1, hashPIN2)

        try HaventecAuthenticate.initialiseStorage(username: username1)

        let hashPIN3 = try HaventecAuthenticate.hashPin(pin: "1234")

        XCTAssertEqual(hashPIN1, hashPIN3)
//
        try HaventecAuthenticate.initialiseStorage(username: username2)

        let hashPIN4 = try HaventecAuthenticate.hashPin(pin: "1234")

        XCTAssertNotEqual(hashPIN1, hashPIN4)

        try HaventecAuthenticate.initialiseStorage(username: username1)

        let hashPIN5 = try HaventecAuthenticate.hashPin(pin: "1234")

        XCTAssertEqual(hashPIN1, hashPIN5)
    }
    
    func testUpdateStorage_success() throws {
        try HaventecAuthenticate.initialiseStorage(username: username1)

        assertAgainstUsername(username: username1)
        
        XCTAssertNil(HaventecAuthenticate.getDeviceUuid())
        XCTAssertNil(HaventecAuthenticate.getAuthKey())
        XCTAssertNil(try HaventecAuthenticate.getAccessToken())
        XCTAssertThrowsError(try HaventecAuthenticate.getUserUuid())

        try HaventecAuthenticate.updateStorage(data: addDeviceResponseJson.data(using: .utf8)!)
        
        assertAgainstUsername(username: username1)
        assertAgainstDeviceUuid(deviceUuid: deviceUuid1)
        
        XCTAssertNil(HaventecAuthenticate.getAuthKey())
        XCTAssertNil(try HaventecAuthenticate.getAccessToken())
        XCTAssertThrowsError(try HaventecAuthenticate.getUserUuid())

        try HaventecAuthenticate.updateStorage(data: activateDeviceResponseJson.data(using: .utf8)!)
        
        assertAgainstUsername(username: username1)
        assertAgainstDeviceUuid(deviceUuid: deviceUuid1)
        assertAgainstAuthKey(authKey: authKey1)
        assertAgainstAccessToken(accessToken: accessToken1)
        assertAgainstUserUuid(userUuid: userUuid1)
    }

    func testUpdateStorage_invalidJsonResponse() throws {
        try HaventecAuthenticate.initialiseStorage(username: username1)
        let expectedErrorMessage = "Unable to decode and deserialize the data given into a JSON object"
        
        do {
            try HaventecAuthenticate.updateStorage(data: invalidJsonResponse.data(using: .utf8)!)
            XCTFail("haventecAuthenticate.jsonError expected")
        } catch HaventecAuthenticateError.invalidData(let errorMsg) {
            XCTAssertEqual(expectedErrorMessage, errorMsg)
        } catch {
            XCTFail("Wrong error thrown")
        }

        XCTAssertNil(HaventecAuthenticate.getDeviceUuid())
    }

    func testTwoUsersSwitch() throws {
        let deviceName = HaventecAuthenticate.getDeviceName()
        XCTAssertNotNil(deviceName)
        
        //
        // First, test that values get set appropriately for username1
        //
        
        try HaventecAuthenticate.initialiseStorage(username: username1)
        
        assertAgainstUsername(username: username1)
        XCTAssertEqual(deviceName, HaventecAuthenticate.getDeviceName())
        XCTAssertNil(HaventecAuthenticate.getDeviceUuid())
        XCTAssertNil(HaventecAuthenticate.getAuthKey())
        XCTAssertNil(try HaventecAuthenticate.getAccessToken())
        XCTAssertThrowsError(try HaventecAuthenticate.getUserUuid())
        
        try HaventecAuthenticate.updateStorage(data: addDeviceResponseJson.data(using: .utf8)!)
        try HaventecAuthenticate.updateStorage(data: activateDeviceResponseJson.data(using: .utf8)!)
        
        XCTAssertEqual(deviceName, HaventecAuthenticate.getDeviceName())
        assertAgainstUsername(username: username1)
        assertAgainstDeviceUuid(deviceUuid: deviceUuid1)
        assertAgainstAuthKey(authKey: authKey1)
        assertAgainstAccessToken(accessToken: accessToken1)
        assertAgainstUserUuid(userUuid: userUuid1)


        //
        // Now test onboarding a second user
        //

        try HaventecAuthenticate.initialiseStorage(username: username2)
        
        assertAgainstUsername(username: username2)
        XCTAssertEqual(deviceName, HaventecAuthenticate.getDeviceName())
        XCTAssertNil(HaventecAuthenticate.getDeviceUuid())
        XCTAssertNil(HaventecAuthenticate.getAuthKey())
        XCTAssertNil(try HaventecAuthenticate.getAccessToken())
        XCTAssertThrowsError(try HaventecAuthenticate.getUserUuid())
        
        try HaventecAuthenticate.updateStorage(data: addDeviceResponseJson2.data(using: .utf8)!)
        try HaventecAuthenticate.updateStorage(data: activateDeviceResponseJson2.data(using: .utf8)!)
        
        XCTAssertEqual(deviceName, HaventecAuthenticate.getDeviceName())
        assertAgainstUsername(username: username2)
        assertAgainstDeviceUuid(deviceUuid: deviceUuid2)
        assertAgainstAuthKey(authKey: authKey2)
        assertAgainstAccessToken(accessToken: accessToken2)
        assertAgainstUserUuid(userUuid: userUuid2)

        //
        // Now test that switching back to the first user retains the context, so we haven't lost any data
        //

        try HaventecAuthenticate.initialiseStorage(username: username1)
        
        XCTAssertEqual(deviceName, HaventecAuthenticate.getDeviceName())
        assertAgainstUsername(username: username1)
        assertAgainstDeviceUuid(deviceUuid: deviceUuid1)
        assertAgainstAuthKey(authKey: authKey1)
        XCTAssertNil(try HaventecAuthenticate.getAccessToken())
        XCTAssertThrowsError(try HaventecAuthenticate.getUserUuid())
    }
    
    // Helper methods to test unwrapping of optionals and throwables
    private func assertAgainstUsername(username: String?) {
        XCTAssertNotNil(HaventecAuthenticate.getUsername())
        XCTAssertEqual(HaventecAuthenticate.getUsername()!, username)
    }
    
    private func assertAgainstDeviceUuid(deviceUuid: String?) {
        XCTAssertNotNil(HaventecAuthenticate.getDeviceUuid())
        XCTAssertEqual(deviceUuid, HaventecAuthenticate.getDeviceUuid())
    }
    
    private func assertAgainstAuthKey(authKey: String?) {
        XCTAssertNotNil(HaventecAuthenticate.getAuthKey())
        XCTAssertEqual(authKey, HaventecAuthenticate.getAuthKey())
    }
    
    private func assertAgainstAccessToken(accessToken: String?) {
        XCTAssertNoThrow(try HaventecAuthenticate.getAccessToken())
        XCTAssertNotNil(try! HaventecAuthenticate.getAccessToken())
        XCTAssertEqual(accessToken, try! HaventecAuthenticate.getAccessToken()!)
    }
    
    private func assertAgainstUserUuid(userUuid: String?) {
        XCTAssertNoThrow(try HaventecAuthenticate.getUserUuid())
        XCTAssertNotNil(try! HaventecAuthenticate.getUserUuid())
        XCTAssertEqual(userUuid, try! HaventecAuthenticate.getUserUuid()!)
    }
}
