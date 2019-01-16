//
//  BookRealmDb.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import Foundation
import RealmSwift

class BookRealmDb {
    
    let realm: Realm = try! Realm()
    
    //USER
    func createDbUser(_id: String, username: String, token: String) -> RealmUser {
        let dbUser = RealmUser()
        dbUser._id = _id
        dbUser.username = username
        dbUser.token = token
        return dbUser
    }
    
    
    func saveUser(user: RealmUser) {
        try! realm.write {
            realm.add(user)
        }
    }
    func updateUser(user: RealmUser) {
        try! realm.write {
            realm.add(user, update: true)
        }
    }
    func deleteUser(user: RealmUser) {
        try! realm.write {
            realm.delete(user)
        }
    }
    public func findUserByID(by id: String) -> Results<RealmUser>
    {
        let predicate = NSPredicate(format: "_id = %@", id)
        return realm.objects(RealmUser.self).filter(predicate)
    }
    
    //BOOKS
    func createDbBook(_id: String, title: String, bookdescription: String, contact: String, user_id: String, image_filename: String, price: String) -> RealmBook {
        let dbBook = RealmBook()
        dbBook._id = _id
        dbBook.title = title
        dbBook.bookdescription = bookdescription
        dbBook.contact = contact
        dbBook.price = price
        dbBook.user_id = user_id
        dbBook.image_filename = image_filename
        return dbBook
    }
    
    func saveBook(book: RealmBook) {
        try! realm.write {
            realm.add(book)
        }
    }
    func updateBook(book: RealmBook) {
        try! realm.write {
            realm.add(book, update: true)
        }
    }
    func deleteBook(book: RealmBook) {
        try! realm.write {
            realm.delete(book)
        }
    }
    
    public func findBookByID(by id: String) -> Results<RealmBook>
    {
        let predicate = NSPredicate(format: "_id = %@", id)
        return realm.objects(RealmBook.self).filter(predicate)
    }
    
    public func getAllBooks() -> Results<RealmBook> {
        return realm.objects(RealmBook.self)
    }
    
    public func getOwnBooks(by userId: String) -> Results<RealmBook> {
        let predicate = NSPredicate(format: "user_id = %@", userId)
        return realm.objects(RealmBook.self).filter(predicate)
    }
    
}
