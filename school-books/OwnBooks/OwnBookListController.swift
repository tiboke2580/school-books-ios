//
//  OwnBookListControler.swift
//  school-books
//
//  Created by Thibaut Maddelein on 16/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import Nuke

class OwnBookListController: UIViewController{
    
    private let SERVER_IMG_URL = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3003/API/file/file?file_name="
    private let localDB = BookRealmDb()
    private let bookViewModel = BookViewModel()
    private var books:Results<RealmBook>!
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        self.books = localDB.getOwnBooks(by: AuthenticationController.getUserId()!)
    }

    
        

}

extension OwnBookListController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ownBookViewCell", for: indexPath) as! OwnBookViewCell
        let book = books[indexPath.row]
        cell.book = book
        
        cell.title.text = book.title
        cell.bookDescription.text = book.bookdescription
        cell.contact.text = book.contact
        cell.price.text = book.price
        let url = URL(string: SERVER_IMG_URL + book.image_filename!)
        Nuke.loadImage(with: url!, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)), into: cell.bookImage)

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let book = books[indexPath.row]
            UserClient.deleteBook(id: book._id!)
                .observeOn(MainScheduler.instance)
                .subscribe( onNext: { result in
                    self.localDB.deleteBook(book: book)
                    self.bookViewModel.getBooks()
                    let realm: Realm = try! Realm()
                    realm.refresh()
                    self.books = self.localDB.getOwnBooks(by: AuthenticationController.getUserId()!)
                }, onError: {
                    error in
                    switch error {
                    case APIErrorConstants.unAuthorized:
                        print("401 error")
                    case APIErrorConstants.notFound:
                        print("404 error")
                    default:
                        print("Unknown error:", error)
                    }
                }
            ).disposed(by: disposeBag)
            
        }
    }
    
    
}
