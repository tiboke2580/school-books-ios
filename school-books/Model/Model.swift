//
//  Model.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation

struct Login: Codable {
    var username: String
    var password: String
}

struct Register: Codable {
    var username: String
    var password: String
}

struct User: Codable {
    var _id: String?
    var username: String?
    var token: String?
    var books: [String]?
}

struct Book: Codable{
    var _id: String
    var title: String
    var description: String
    var image_filename: String
    var contact: String
    var price: String
    var user_id: String
}
