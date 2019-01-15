//
//  AuthenticationController.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation
import KeychainSwift

class AuthenticationController {
    
    static func login(token: String, _id: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: "userToken")
        keychain.set(_id, forKey: "userID")
        
    }
    
    static func getToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("userToken")
    }
    
    static func getUserId() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("userID")
    }
    
    static func logout() {
        let keychain = KeychainSwift()
        keychain.delete("userToken")
        keychain.delete("userID")
        
    }
}

