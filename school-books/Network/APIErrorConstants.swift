//
//  APIErrorConstants.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation

enum APIErrorConstants: Error {
    case unAuthorized
    case notFound
    case internalServerError
}
