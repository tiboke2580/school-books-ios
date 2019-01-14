

import UIKit
import Alamofire

class LoginVC: UIViewController {
    

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func doLogin(_ sender: Any) {
        
            let parameters = [
                "username": username.text!,
                "password": password.text!]
            
            let url = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3003/API/users/login"
            
            Alamofire.request(url, method:.post, parameters:parameters, encoding : JSONEncoding.default)
                .responseJSON{ response in
                    switch response.result {
                    case .success:
                        let res = response.response!.statusCode;
                        if(res != 400 && res != 401){
                            
                            let jsonDecoder = JSONDecoder()
                            if let data = response.data, let user = try? jsonDecoder.decode(User.self, from: data){
                                UserDefaults.standard.set(true, forKey: "status")
                                UserDefaults.standard.set(user.token, forKey: "token")
                                UserDefaults.standard.set(user.username, forKey: "username")
                                Switcher.updateRootVC()
                            }
                            
                            
                        }else{
                            print("stop")
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
            }
        }
    
}

