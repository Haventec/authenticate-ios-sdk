import XCTest
import HaventecAuthenticate

class HaventecAuthenticateTest: XCTestCase {
    
    let addDeviceResponseJson: String = "{\"userEmail\":\"justincrosbie@gmail.com\",\"activationToken\":\"493552\",\"deviceUuid\":\"c4acafff-f4be-4d06-b7f6-ab3f16deb50b\",\"mobileNumber\":null,\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Created\",\"code\":\"\"}}";
    let activateDeviceResponseJson: String = "{\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Changed\",\"code\":\"\"},\"authKey\":\"OX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GQ==\",\"accessToken\":{\"type\":\"JWT\",\"token\":\"eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJ0ZXN0IGFwcCIsImV4cCI6MTU0OTk0ODk2NiwiaWF0IjoxNTQ5OTQ0NDY2LCJuYmYiOjE1NDk5NDQzNDYsInN1YiI6ImpjaGFwaTE4XzIiLCJyb2xlIjpbIkhUX0FOX1VTRVIiXSwiYXBwbGljYXRpb25VVUlEIjoiYzA5ZGQ4ZWYtODIzYi00NGU1LWFhNTUtZTQ4YzM5ZjFiMzJkIiwidXNlclVVSUQiOiIzZTIzM2JiYS02NDlhLTRlMjgtYTE0ZS1kYTIyYjIxOTIyNzMiLCJqdGkiOiIyMmc1Z0Q0X3ctc2t0Z1J3V19pVm9BIn0.MSD3kQdVGsAvS3RiRJN5QOP_h6va4Ww6YdHXkS-uls4qxbqcBoTCskL06GWgA5gIY3dqakqlwd9kAYACG4QpphvP0Zu5FEc7_eDhoWE7UesrtJmB5Me8VVlPoxkpDl3t\"}}";
    let addDeviceResponseJson2: String = "{\"userEmail\":\"justincrosbie2@gmail.com\",\"activationToken\":\"493554\",\"deviceUuid\":\"c4acafff-f4be-4d06-b7f6-ab3f16deb51a\",\"mobileNumber\":null,\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Created\",\"code\":\"\"}}";
    let activateDeviceResponseJson2: String = "{\"responseStatus\":{\"status\":\"SUCCESS\",\"message\":\"Changed\",\"code\":\"\"},\"authKey\":\"AX4xNhyVoY7lFzmOLmfFo1PbgZYz2oN4THu5/CgDikwg3epdy5a3cIqn2Xk8sHqG3YyQricznA7RZINwxmC2llcmppwn9gx9C0MSmGld7Fs/WtDWRqHQzW5kvBPkyYoArON4cdP5kga4Bbi97Jx4aR/w0EQ6sxD8gL35kM6wdA39oxzeTt5lhBqLzhXshxOBd4cUVQtBCGV9fFM0YPmMDa76kQtiP6ed2PdPJ/sowBpAGBgxiFyxGoPg1PqQ4FJEq0P4rhYwR02WU3sS6nqg4Ql/nrCj1bWl97kHHFhrAZJxEaQwMoffQzY1XfjhS2zKCWjYpHLeZ7zvZi8caR0T/gjCYaBx9egdM3wzkyftIRbpLo4iGJj9HUbjKitjFqL1Q7jiqQTXYwJins8XVmh/007jft2K3l7tLCI8M0wsXQqhP5i7kf6jS6UIhtuI5vlx6LWyw4ywOJjEuQxRrbS8GA==\",\"accessToken\":{\"type\":\"JWT\",\"token\":\"eyJhbGciOiJFUzM4NCJ9.eyJpc3MiOiJ0ZXN0IGFwcCIsImV4cCI6MTU0OTk0ODk2NiwiaWF0IjoxNTQ5OTQ0NDY2LCJuYmYiOjE1NDk5NDQzNDYsInN1YiI6ImpjaGFwaTE4XzIiLCJyb2xlIjpbIkhUX0FOX1VTRVIiXSwiYXBwbGljYXRpb25VVUlEIjoiYzA5ZGQ4ZWYtODIzYi00NGU1LWFhNTUtZTQ4YzM5ZjFiMzJkIiwidXNlclVVSUQiOiIzZTIzM2JiYS02NDlhLTRlMjgtYTE0ZS1kYTIyYjIxOTIyNzMiLCJqdGkiOiIyMmc1Z0Q0X3ctc2t0Z1J3V19pVm9BIn0.MSD3kQdVGsAvS3RiRJN5QOP_h6va4Ww6YdHXkS-uls4qxbqcBoTCskL06GWgA5gIY3dqakqlwd9kAYACG4QpphvP0Zu5FEc7_eDhoWE7UesrtJmB5Me8VVlPoxkpDl3x\"}}";

    let exceptionThrown = "Haventec Exception was thrown from this call"
    
    let username1 = "testuser1"
    let username2 = "testuser2"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialiseStorage() {
        HaventecAuthenticate.initialiseStorage(username: username1);
        
        guard let thisUsername: String = HaventecAuthenticate.getUsername() else {
            XCTFail("getUsername() didn't return"); return;
        }
        
        XCTAssertEqual(thisUsername, username1);
    }
    
    
    func testUpdateStorage() {
        HaventecAuthenticate.initialiseStorage(username: username1);
        
        if let addDeviceResponseJsonData = addDeviceResponseJson.data(using: .utf8) {
            HaventecAuthenticate.updateStorage(data: addDeviceResponseJsonData);
        } else {
            XCTFail("JSON Parse fail");
        }
        
        guard let thisDeviceUuid: String = HaventecAuthenticate.getDeviceUuid() else {
            XCTFail("thisDeviceUuid() didn't return"); return;
        }
        
        XCTAssertEqual(thisDeviceUuid, "c4acafff-f4be-4d06-b7f6-ab3f16deb50b");
    }
    
    func testTwtoUsersSwitch() {
        HaventecAuthenticate.initialiseStorage(username: username1);
        
        if let addDeviceResponseJsonData = addDeviceResponseJson.data(using: .utf8) {
            HaventecAuthenticate.updateStorage(data: addDeviceResponseJsonData);
        } else {
            XCTFail("JSON Parse fail");
        }
        
        guard let thisDeviceUuid: String = HaventecAuthenticate.getDeviceUuid() else {
            XCTFail("thisDeviceUuid() didn't return"); return;
        }
        
        XCTAssertEqual(thisDeviceUuid, "c4acafff-f4be-4d06-b7f6-ab3f16deb50b");
        
        HaventecAuthenticate.initialiseStorage(username: username2);
        
        if let addDeviceResponseJsonData2 = addDeviceResponseJson2.data(using: .utf8) {
            HaventecAuthenticate.updateStorage(data: addDeviceResponseJsonData2);
        } else {
            XCTFail("JSON Parse fail");
        }
        
        guard let thisDeviceUuid2: String = HaventecAuthenticate.getDeviceUuid() else {
            XCTFail("thisDeviceUuid() didn't return"); return;
        }
        
        XCTAssertEqual(thisDeviceUuid2, "c4acafff-f4be-4d06-b7f6-ab3f16deb51a");
        
        HaventecAuthenticate.initialiseStorage(username: username1);
        
        guard let thisDeviceUuid3: String = HaventecAuthenticate.getDeviceUuid() else {
            XCTFail("thisDeviceUuid() didn't return"); return;
        }
        
        XCTAssertEqual(thisDeviceUuid3, "c4acafff-f4be-4d06-b7f6-ab3f16deb50b");
        

    }
    

}
