//
//  UserRouterApi.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouterApi: URLRequestConvertible {
    
    case login(username:String, password:String)
    case register(username:String, password: String)
    case books
    
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        case .books:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .login:
            return "/API/users/login"
        case .register:
            return "/API/users/register"
        case .books:
            return "/API/book/books"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return [Constants.APIParameterKey.username: username, Constants.APIParameterKey.password: password]
        case .register(let username, let password):
            return [Constants.APIParameterKey.username: username, Constants.APIParameterKey.password: password]
        case .books:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        print(urlRequest)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers

        
        // Parameters
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
