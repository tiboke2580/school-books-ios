//
//  AddBookController.swift
//  school-books
//
//  Created by Thibaut Maddelein on 16/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import UIKit
import Alamofire
import Realm
import RxSwift

class AddBookController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookDescription: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var image: UIImageView!

    private let localDB = BookRealmDb()
    private let disposeBag = DisposeBag()
    

    
    @IBOutlet weak var lblValidation: UILabel!
    @IBOutlet weak var cellValidation: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.hidesBackButton = true;
        cellValidation.isHidden = true
    }
    
    func validation(_ text: String)
    {
        lblValidation.text = text
        cellValidation.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case bookTitle:
            bookDescription.becomeFirstResponder()
        case bookDescription:
            contact.becomeFirstResponder()
        case contact:
            price.becomeFirstResponder()
        case price:
            price.resignFirstResponder()
        default:
            bookTitle.becomeFirstResponder()
        }
        return true
    }
    
    @IBAction func tappedImage(_ sender: UIView) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Kies foto", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "photo library", style: .default, handler: {
                action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage =
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            image.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func addBook(_ sender: Any) {
        view.endEditing(true)
        
        guard let bookTitle = bookTitle.text, bookTitle != "" else {
            validation("Titel moet ingevuld zijn")
            return
        }
        guard let bookDescription = bookDescription.text, bookDescription != "" else {
            validation("Beschrijving moet ingevuld zijn")
            return
        }
        
        guard let contact = contact.text, contact != "" else {
            validation("Email of telefoon moet ingevuld zijn")
            return
        }
        guard let price = price.text, price != "" else {
            validation("Prijs moet ingevuld zijn")
            return
        }
        
        
        
        UserClient.addBook(bookTitle: bookTitle, bookDescription: bookDescription, bookContact: contact, bookPrice: price, userId: AuthenticationController.getUserId()! ,file: image.image!)
            .observeOn(MainScheduler.instance)
            .subscribe( onNext: { result in
               let book = self.localDB.createDbBook(_id: result._id, title: result.title, bookdescription: result.description, contact: result.contact, user_id: result.user_id, image_filename: result.image_filename, price: result.price)
                
                self.localDB.saveBook(book: book)
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
        

    
        
        self.performSegue(withIdentifier: "addBookSegue", sender: self)
        

    }
    

    
        
}


