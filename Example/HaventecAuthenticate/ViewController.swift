//
//  ViewController.swift
//  HaventecCommon
//
//  Created by Clifford Phan on 01/29/2019.
//  Copyright (c) 2019 Clifford Phan. All rights reserved.
//
import UIKit
import HaventecAuthenticate

class ViewController: UIViewController, NSURLConnectionDataDelegate {
    var serverUrl: String!
    
    // Add Device Request
    var applicationUuid: String!
    var apiKey: String!
    var haventecUsername: String!
    var haventecEmail: String!
    
    // Activate Device Request
    var pinCode: String!
    
    // Add Device Response
    var activationToken: String!
    var deviceUuid: String!
    
    // Activate Device Response
    var authKey: String!
    var accessToken: AccessToken!
    
    // UIKit
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var addDeviceButton: UIButton!
    @IBOutlet weak var activateDeviceButton: UIButton!

    @IBOutlet weak var currentUsername: UILabel!
    @IBOutlet weak var currentDeviceUuid: UILabel!
    @IBOutlet weak var currentAccessToken: UILabel!
    @IBOutlet weak var currentAuthKey: UILabel!
    @IBOutlet weak var loginMessage: UILabel!
    
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var addDeviceStatus: UILabel!
    @IBOutlet weak var addDeviceMessage: UILabel!
    @IBOutlet weak var addDeviceCode: UILabel!
    @IBOutlet weak var addDeviceActivationToken: UILabel!
    @IBOutlet weak var addDeviceDeviceUuid: UILabel!
    
    @IBOutlet weak var activateDeviceStatus: UILabel!
    @IBOutlet weak var activateDeviceMessage: UILabel!
    @IBOutlet weak var activateDeviceCode: UILabel!
    @IBOutlet weak var activateDeviceAuthKey: UILabel!
    @IBOutlet weak var activateDeviceAccessTokenValue: UILabel!
    @IBOutlet weak var activateDeviceAccessTokenType: UILabel!

    @IBOutlet weak var activateDeviceUserUuid: UILabel!
    
    private func loadPropertyFile() {
        guard let fileUrl = Bundle.main.url(forResource: "App", withExtension: "plist") else { return }
        guard let properties = NSDictionary(contentsOf: fileUrl) as? [String:Any] else { return }
        
        serverUrl = properties["serverUrl"] as? String
        applicationUuid = properties["applicationUuid"] as? String
        apiKey = properties["apiKey"] as? String
        haventecUsername = properties["haventecUsername"] as? String
        haventecEmail = properties["haventecEmail"] as? String
        pinCode = properties["pinCode"] as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Model: \(UIDevice().model)")
        print("UUID: \(UIDevice().identifierForVendor!)")
        print("Name: \(UIDevice().name)")
        print("SysName: \(UIDevice().systemName)")
        print("SysVer: \(UIDevice().systemVersion)")
        print("Description: \(UIDevice().description)")
        print("LModel: \(UIDevice().localizedModel)")

        loadPropertyFile()
        // Do any additional setup after loading the view, typically from a nib.

        currentAccessToken.font = currentAccessToken.font.withSize(10)
        currentAuthKey.font = currentAuthKey.font.withSize(10)
        currentDeviceUuid.font = currentDeviceUuid.font.withSize(10)
        currentUsername.font = currentUsername.font.withSize(10)
        loginMessage.font = loginMessage.font.withSize(10)
        deviceName.font = deviceName.font.withSize(10)
        addDeviceStatus.font = addDeviceStatus.font.withSize(10)
        addDeviceMessage.font = addDeviceStatus.font.withSize(10)
        addDeviceCode.font = addDeviceStatus.font.withSize(10)
        addDeviceActivationToken.font = addDeviceStatus.font.withSize(10)
        addDeviceDeviceUuid.font = addDeviceStatus.font.withSize(10)
        
        activateDeviceStatus.font = activateDeviceStatus.font.withSize(10)
        activateDeviceMessage.font = activateDeviceMessage.font.withSize(10)
        activateDeviceCode.font = activateDeviceCode.font.withSize(10)
        activateDeviceAuthKey.font = activateDeviceAuthKey.font.withSize(10)
        activateDeviceAccessTokenValue.font = activateDeviceAccessTokenValue.font.withSize(10)
        activateDeviceAccessTokenType.font = activateDeviceAccessTokenType.font.withSize(10)
        activateDeviceUserUuid.font = activateDeviceUserUuid.font.withSize(10)

        self.deviceName.text = "Device name: " + HaventecAuthenticate.getDeviceName()
        
        do {
            try HaventecAuthenticate.initialiseStorage(username: haventecUsername)
            
            if let currentUsername = HaventecAuthenticate.getUsername() {
                self.currentUsername.text = "Current username: " + currentUsername
            } else {
                self.currentUsername.text = "No username: User not initialised"
            }
            if let currentDeviceUuid = HaventecAuthenticate.getDeviceUuid() {
                self.currentDeviceUuid.text = "Current deviceUuid: " + currentDeviceUuid
            } else {
                self.currentDeviceUuid.text = "No deviceUuid: Device not Added"
            }
            if let currentAuthKey = HaventecAuthenticate.getAuthKey() {
                self.currentAuthKey.text = "Current authKey: " + currentAuthKey
            } else {
                self.currentAuthKey.text = "No authKey: Device not Activated"
            }
            if let currentAccessToken = try HaventecAuthenticate.getAccessToken() {
                self.currentAccessToken.text = "Current accessToken: " + currentAccessToken
            } else {
                self.currentAccessToken.text = "No accessToken: Device not Logged in or Activated"
            }
            
        } catch {
            print("error=\(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doLogin(_ sender: Any) {
        
        if let currentDeviceuuid = HaventecAuthenticate.getDeviceUuid() {
            let hashedPinOptional: String?;
            do {
                try hashedPinOptional = HaventecAuthenticate.hashPin(pin: pinCode)
            } catch {
                print("******* hashPin is broke - BCKCOMPAT FAIL!!!")
                print("error=\(error)")
                self.loginMessage.text = "hashPin is broke - BCKCOMPAT FAIL!!!"
            }
            guard let hashedPinOptional1 = try? HaventecAuthenticate.hashPin(pin: pinCode) else { return }
            guard let hashedPinOptional2 = try? HaventecAuthenticate.hashPin(pin: pinCode) else { return }
            guard let hashedPin: String = hashedPinOptional1 else { return }
            guard let hashedPin2: String = hashedPinOptional2 else { return }
            
            if ( hashedPin != hashedPin2 ) {
                print("******* hashPin is broke")
            }
            let url = URL(string: serverUrl + "/authentication/login")!
            
            let username = try HaventecAuthenticate.getUsername()!
            let deviceUuid = try HaventecAuthenticate.getDeviceUuid()!
            let authKey = try HaventecAuthenticate.getAuthKey()!
            
            let jsonString: String = "{"
                + "\"applicationUuid\": \"\(applicationUuid)\","
                + "\"username\": \"\(username)\","
                + "\"deviceUuid\": \"\(deviceUuid)\","
                + "\"hashedPin\": \"\(hashedPin)\","
                + "\"authKey\": \"\(authKey)\""
                + "}";
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
            request.httpMethod = "POST"
            request.httpBody = jsonString.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    DispatchQueue.main.async {
                        self.loginMessage.text = "Response Status: UNSUCCESSFUL"
                    }
                    print("error=\(error!)")
                    return
                }
                
                do {
                    try HaventecAuthenticate.updateStorage(data: data);
                } catch {
                    print("error=\(error)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    let jsonData = responseString!.data(using: .utf8)!
                    let decoder = JSONDecoder()
                    
                    do {
                        let response = try decoder.decode(ActivateDeviceResponse.self, from: jsonData)
                        self.authKey = response.authKey
                        self.accessToken = response.accessToken
                        
                        if let currentUsername = HaventecAuthenticate.getUsername() {
                            self.currentUsername.text = "Current username: " + currentUsername
                        } else {
                            self.currentUsername.text = "No username: User not initialised"
                        }
                        if let currentDeviceUuid = HaventecAuthenticate.getDeviceUuid() {
                            self.currentDeviceUuid.text = "Current deviceUuid: " + currentDeviceUuid
                        } else {
                            self.currentDeviceUuid.text = "No deviceUuid: Device not Added"
                        }
                        if let currentAuthKey = HaventecAuthenticate.getAuthKey() {
                            self.currentAuthKey.text = "Current authKey: " + currentAuthKey
                        } else {
                            self.currentAuthKey.text = "No authKey: Something has gone wrong"
                        }
                        if let currentAccessToken = try HaventecAuthenticate.getAccessToken() {
                            self.currentAccessToken.text = "Current accessToken: " + currentAccessToken
                        } else {
                            self.currentAccessToken.text = "No accessToken: Something has gone wrong"
                        }
                        
                        self.loginMessage.text = "Response Message: " + response.responseStatus.message
                        
                    } catch {
                        print("Unexpected error: \(error)")
                        return
                    }
                }
                print("responseString = \(responseString!)")
            }

            task.resume()
        } else {
            self.loginMessage.text = "Device not Activated. Please Add and Activate the device first"
        }
        
    }
    
    @IBAction func addDevice() {
        let url = URL(string: serverUrl + "/self-service/device")!
        
        let jsonString: String = "{"
            + "\"applicationUuid\": \"\(applicationUuid)\","
            + "\"username\": \"\(haventecUsername)\","
            + "\"email\": \"\(haventecEmail)\","
            + "\"deviceName\": \"iOS Device\""
            + "}";
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        request.httpBody = jsonString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                DispatchQueue.main.async {
                    self.addDeviceMessage.text = "Response Status: UNSUCCESSFUL"
                }
                print("error=\(error!)")
                return
            }
            
            do {
                try HaventecAuthenticate.updateStorage(data: data);
            } catch {
                print("error=\(error)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            DispatchQueue.main.async {

                let jsonData = responseString!.data(using: .utf8)!
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(AddDeviceResponse.self, from: jsonData)
                    self.deviceUuid = response.deviceUuid
                    self.activationToken = response.activationToken
                    
                    self.addDeviceCode.text = "Response Code: " + response.responseStatus.code
                    self.addDeviceMessage.text = "Response Message: " + response.responseStatus.message
                    self.addDeviceStatus.text = "Response Status: " + response.responseStatus.status
                    self.addDeviceDeviceUuid.text = "Device UUID: " + HaventecAuthenticate.getDeviceUuid()!
                    self.addDeviceActivationToken.text = "Activation Token: " +  self.activationToken
                } catch {
                    print("Unexpected error: \(error)")
                    return
                }
            }
            print("responseString = \(responseString!)")
        }
        
        task.resume()
    }
    
    @IBAction func activateDevice() {
        guard let hashedPinOptional = try? HaventecAuthenticate.hashPin(pin: pinCode) else { return }
        guard let hashedPinOptional2 = try? HaventecAuthenticate.hashPin(pin: pinCode) else { return }
        guard let hashedPin: String = hashedPinOptional else { return }
        guard let hashedPin2: String = hashedPinOptional2 else { return }

        if ( hashedPin != hashedPin2 ) {
            print("******* hashPin is broke")
        }
        let url = URL(string: serverUrl + "/authentication/activate/device")!
        
        let jsonString: String = "{"
            + "\"applicationUuid\": \"\(applicationUuid)\","
            + "\"username\": \"\(haventecUsername)\","
            + "\"deviceUuid\": \"\(deviceUuid)\","
            + "\"hashedPin\": \"\(hashedPin)\","
            + "\"activationToken\": \"\(activationToken)\""
            + "}";
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        request.httpBody = jsonString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                DispatchQueue.main.async {
                    self.activateDeviceMessage.text = "Response Status: UNSUCCESSFUL"
                }
                print("error=\(error!)")
                return
            }
            
            do {
                try HaventecAuthenticate.updateStorage(data: data);
            } catch {
                print("error=\(error)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            DispatchQueue.main.async {
                let jsonData = responseString!.data(using: .utf8)!
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(ActivateDeviceResponse.self, from: jsonData)
                    self.authKey = response.authKey
                    self.accessToken = response.accessToken
                    
                    self.activateDeviceCode.text = "Response Code: " + response.responseStatus.code
                    self.activateDeviceMessage.text = "Response Message: " + response.responseStatus.message
                    self.activateDeviceStatus.text = "Response Status: " + response.responseStatus.status
                    self.activateDeviceAuthKey.text = "Auth key: " + HaventecAuthenticate.getAuthKey()!
                    self.activateDeviceAccessTokenValue.text = try "Token: " + HaventecAuthenticate.getAccessToken()!
                    self.activateDeviceAccessTokenType.text = "Token Type: " + self.accessToken.type

                    if let currentAuthKey = HaventecAuthenticate.getAuthKey() {
                        self.currentAuthKey.text = "Current authKey: " + currentAuthKey
                    } else {
                        self.currentAuthKey.text = "Device not Activated"
                    }
                    if let currentAccessToken = try HaventecAuthenticate.getAccessToken() {
                        self.currentAccessToken.text = "Current accessToken: " + currentAccessToken
                    } else {
                        self.currentAccessToken.text = "Device not Logged in or Activated"
                    }

                    self.activateDeviceUserUuid.text = try "User Uuid: " + HaventecAuthenticate.getUserUuid()!
                } catch {
                    print("Unexpected error: \(error)")
                    return
                }
            }
            print("responseString = \(responseString!)")
        }
        
        task.resume()
    }
    
    @IBAction func clearAccessToken() {
        
        HaventecAuthenticate.clearAccessToken();
    
        self.activateDeviceAuthKey.text = "Auth key: " + HaventecAuthenticate.getAuthKey()!
        
        if let result = try? HaventecAuthenticate.getAccessToken(), let accessToken = result {
            self.activateDeviceAccessTokenValue.text = "Token: " + accessToken
        } else {
            self.activateDeviceAccessTokenValue.text = "Token has been cleared"
        }
        
        if let userUuidOpt = try? HaventecAuthenticate.getUserUuid(), let userUuid = userUuidOpt {
            self.activateDeviceUserUuid.text = "User Uuid: " + userUuid
        } else {
            self.activateDeviceUserUuid.text = "accessToken no longer valid, cannot get userUuid"
        }
    }

    @IBAction func regenerateSaltAction() {
        
        do {
            try HaventecAuthenticate.regenerateSalt(username: haventecUsername);
        } catch {
            print("Unexpected error: \(error)")
            return
        }
    }
}
