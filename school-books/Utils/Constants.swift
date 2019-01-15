//
//  Constants.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation

struct Constants {
    static let baseURL = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3003"
    
    struct APIParameterKey {
        static let password = "password"
        static let username = "username"

    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
