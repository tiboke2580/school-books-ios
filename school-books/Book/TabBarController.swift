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
import Nuke

class TabBarController: UIViewController {
    
    private let SERVER_IMG_URL = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3003/API/file/file?file_name="
    private let localDB = BookRealmDb()
    private var books: Results<RealmBook>!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        books = localDB.getAllBooks()
    }
    
    @IBAction func ownBookList(_ sender: Any) {
        self.performSegue(withIdentifier: "bookListSegue", sender: self)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        AuthenticationController.logout()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "start") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
        
        //https://stackoverflow.com/questions/27374759/programmatically-navigate-to-another-view-controller-scene
    }
}

extension TabBarController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookViewCell", for: indexPath) as! BookViewCell
        let book = books[indexPath.row]
        cell.book = book
        
        cell.bookTitle.text = book.title
        cell.bookDescription.text = book.bookdescription
        cell.contact.text = book.contact
        cell.price.text = book.price
        let url = URL(string: SERVER_IMG_URL + book.image_filename!)
        Nuke.loadImage(with: url!, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)), into: cell.bookImage)
        
        

        return cell
    }
    

}
