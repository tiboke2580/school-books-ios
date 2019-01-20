//
//  OwnBookViewCell.swift
//  school-books
//
//  Created by Thibaut Maddelein on 16/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import UIKit

class OwnBookViewCell : UITableViewCell {
    

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var book: RealmBook! {
        didSet {
            title.text = book.title
            bookDescription.text = book.bookdescription
            contact.text = book.contact
            price.text = book.price
        }
    }
}
