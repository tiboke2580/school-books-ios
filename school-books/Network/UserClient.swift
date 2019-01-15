//
//  UserClient.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class UserClient {
    static func login(username: String, password: String) -> Observable<User> {
        return request(UserRouterApi.login(username: username, password: password))
    }
    
    static func register(username: String, password: String) -> Observable<User> {
        return request(UserRouterApi.register(username: username, password: password))
    }
    
    static func getBooks() -> Observable<Array<Book>> {
        return request(UserRouterApi.books)
    }
    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        let jsonDecoder = JSONDecoder()
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible).responseDecodable (decoder: jsonDecoder) { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 401:
                        observer.onError(APIErrorConstants.unAuthorized)
                    case 404:
                        observer.onError(APIErrorConstants.notFound)
                    case 500:
                        observer.onError(APIErrorConstants.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

