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
    
    static func deleteBook(id: String) -> Observable<Book>{
        return request(UserRouterApi.delete(id: id))
    }
    
    static func addBook(bookTitle: String, bookDescription:String, bookContact: String, bookPrice:String, userId:String ,file:UIImage){

        let parameters = [Constants.APIBookParameterKey.title: bookTitle, Constants.APIBookParameterKey.description: bookDescription, Constants.APIBookParameterKey.contact: bookContact, Constants.APIBookParameterKey.price: bookPrice, Constants.APIBookParameterKey.user_id: userId]

        //source https://stackoverflow.com/questions/26171901/swift-write-image-from-url-to-local-file
        do {
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileName = "filename"
            let fileURL = documentsURL.appendingPathComponent("\(fileName).jpg")

            if let pngImageData = file.jpegData(compressionQuality: 0) {
   
                try pngImageData.write(to: fileURL, options: .atomic)
                
                if FileManager.default.fileExists(atPath: fileURL.path) {
                        AF.upload(
                            multipartFormData: { multipartFormData in
                                multipartFormData.append(fileURL, withName: "file")
                                for (key, value) in parameters {
                                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                                }
                        },
                            to: "http://projecten3studserver03.westeurope.cloudapp.azure.com:3003/API/book/book"

                        )
                    
                }
            }
            
        } catch {
            print("fail")
        }
        
        
        
        
        
    }
    
    
    
    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        let jsonDecoder = JSONDecoder()
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible).responseDecodable (decoder: jsonDecoder) { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    if(response.response?.statusCode != 400 && response.response?.statusCode != 401)
                    {
                        observer.onNext(value)
                        observer.onCompleted()
                    }
                    
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

