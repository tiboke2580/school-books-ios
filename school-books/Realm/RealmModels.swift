//
//  RealmModels.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @objc dynamic var _id: String? = ""
    @objc dynamic var username: String? = ""
    @objc dynamic var token: String? = ""
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}

class RealmBook: Object {
    @objc dynamic var _id: String? = ""
    @objc dynamic var title: String? = ""
    @objc dynamic var bookdescription: String? = ""
    @objc dynamic var contact: String? = ""
    @objc dynamic var price: String? = ""
    @objc dynamic var user_id: String? = ""
    @objc dynamic var image_filename: String? = ""
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}
