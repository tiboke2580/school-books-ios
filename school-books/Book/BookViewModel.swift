//
//  BookViewModel.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation
import RxSwift

class BookViewModel {
    private let disposeBag = DisposeBag()
    private let localDB = BookRealmDb()
    
    func getBooks() {
        UserClient.getBooks()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                result.forEach({ book in
                    if (self.localDB.findBookByID(by: book._id).isEmpty) {
                        let realmbook = self.localDB.createDbBook(_id: book._id, title: book.title, bookdescription: book.description, contact: book.contact, user_id: book.user_id, image_filename: book.image_filename, price: book.price)
                        self.localDB.saveBook(book: realmbook)
                    }
                })
            }, onError: { error in
                switch error {
                case APIErrorConstants.unAuthorized:
                    print("401 error")
                case APIErrorConstants.notFound:
                    print("404 error")
                default:
                    print("Unknown error:", error)
                }
            })
            .disposed(by: disposeBag)
    }
}
