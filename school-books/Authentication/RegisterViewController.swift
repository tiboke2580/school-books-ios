//
//  RegisterViewController.swift
//  school-books
//
//  Created by Thibaut Maddelein on 16/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//
import UIKit
import RxSwift

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordRepeat: UITextField!
    private let localDB = BookRealmDb()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    

    @IBAction func doRegister(_ sender: Any) {
        
        view.endEditing(true)
        
        guard let username = username.text, username.count > 0 else {
            return
        }
        guard let password = password.text, password.count > 0 else {
            return
        }
        guard let passwordRepeat = passwordRepeat.text, passwordRepeat.count > 0 else {
            return
        }
        
        if (password == passwordRepeat) {
            UserClient.register(username: username, password: password)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { result in
                    print(result)
                    if (result.token != nil) {
                        //We place _id and token in the User Keychain
                        AuthenticationController.login(token: result.token!, _id: result._id!)
                        
                        if (self.localDB.findUserByID(by: result._id!).isEmpty) {
                            let dbUser = self.localDB.createDbUser(_id: result._id!, username: result.username!, token: result.token!)
                            self.localDB.saveUser(user: dbUser)
                        }
                        
                        self.performSegue(withIdentifier: "registerSegue", sender: self)
                    }
                }, onError: { error in
                    switch error {
                    case APIErrorConstants.unAuthorized:
                        print("401 error")
                    case APIErrorConstants.notFound:
                        print("404 error")
                    default:
                        print("Unknown error:", error)
                    }
                })
                .disposed(by: disposeBag)
        }
    }
}
