//
//  BookViewCell.swift
//  school-books
//
//  Created by Thibaut Maddelein on 15/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import UIKit

class BookViewCell : UITableViewCell {
    
    
   
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    
    var book: RealmBook! {
        didSet {
            bookTitle.text = book.title
            bookDescription.text = book.bookdescription
            bookDescription.sizeToFit()
            contact.text = book.contact
            price.text = book.price
        }
    }
    
}
