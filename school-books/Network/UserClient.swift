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
    
    static func addBook(title:String, description:String, contact:String, price:String, file:UIImage){
        
        var imageToUpload = file
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("Image2.png") //Your image name here
            let image    = UIImage(contentsOfFile: imageURL.path)
            imageToUpload = image!
        }
        
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageToUpload.jpegData(compressionQuality: 0)!, withName: "Prescription", fileName: "Profile_Image.jpeg", mimeType: "image/jpeg")
        }, to:"http://projecten3studserver03.westeurope.cloudapp.azure.com:3003/uploads")
        
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

