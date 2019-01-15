//
//  TabVC.swift
//  school-books
//
//  Created by Thibaut Maddelein on 14/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class TabBarVC: UIViewController {
    
    
    private let localDB = BookRealmDb()
    private lazy var books: Results<RealmBook> = {
        localDB.getAllBooks()
    }()
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logout(_ sender: Any) {
            AuthenticationController.logout()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "start") as! UINavigationController
            self.present(nextViewController, animated:true, completion:nil)
            
            //https://stackoverflow.com/questions/27374759/programmatically-navigate-to-another-view-controller-scene
    }
}

extension TabBarVC : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookCell
        let book = books[indexPath.row]
        print(books)
        print(book)
        cell.book = book
        
        cell.title.text = book.title
        cell.bookDescription.text = book.bookdescription
        cell.contact.text = book.contact
        cell.price.text = book.price

        return cell
    }
    

}
