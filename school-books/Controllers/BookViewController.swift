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

class BookViewController: UITableViewController{
    
    private let SERVER_IMG_URL = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3003/API/file/file?file_name="
    private let localDB = BookRealmDb()
    private var books: Results<RealmBook>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        self.books = try! Realm().objects(RealmBook.self)
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)

        
    }
    
    @objc func refresh(sender:AnyObject)
    {
        // Updating your data here...
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool){
        let realm: Realm = try! Realm()
        realm.refresh()
        self.tableView.reloadData()
    }
    
    
    @IBAction func logout(_ sender: Any) {
        AuthenticationController.logout()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "start") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
        
        //https://stackoverflow.com/questions/27374759/programmatically-navigate-to-another-view-controller-scene
    }
    
    @IBAction func unwindFromAddProject(_ segue: UIStoryboardSegue) {
        if segue.source is AddBookController {
          
            self.tableView.insertRows(at: [IndexPath(row: books.count - 1, section: 0)], with: .automatic)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
