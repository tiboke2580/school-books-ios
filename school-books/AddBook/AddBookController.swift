//
//  AddBookController.swift
//  school-books
//
//  Created by Thibaut Maddelein on 16/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import UIKit
import Alamofire
import CropViewController

class AddBookController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate{
    
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookDescription: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
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
        
        guard let bookTitle = bookTitle.text, bookTitle.count > 0 else {
            return
        }
        guard let bookDescription = bookDescription.text, bookDescription.count > 0 else {
            return
        }
        
        guard let contact = contact.text, contact.count > 0 else {
            return
        }
        guard let price = price.text, price.count > 0 else {
            return
        }
        
        UserClient.addBook(bookTitle: bookTitle, bookDescription: bookDescription, bookContact: contact, bookPrice: price, userId: AuthenticationController.getUserId()! ,file: image.image!)
        
        self.performSegue(withIdentifier: "addBookSegue", sender: self)

    }
    
        
}


