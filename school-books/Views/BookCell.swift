import UIKit

class BookCell : UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var contact: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var bookDescription: UILabel!
    
    
    var book: RealmBook! {
        didSet {
            title.text = book.title
            bookDescription.text = book.bookdescription
            contact.text = book.contact
            price.text = book.price
        }
    }
}
