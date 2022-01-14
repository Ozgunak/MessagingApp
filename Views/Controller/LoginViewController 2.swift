//
//  LoginViewController.swift
//  Views
//
//  Created by ozgun on 13.01.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var paswordTextField: UITextField!
    @IBOutlet weak var notifyLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = paswordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error{
                    print(e)
                }else{
                    print("Succesfully logged in")
                    self!.performSegue(withIdentifier: K.mainSegue, sender: self)
                }
            }
        }
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = paswordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.notifyLable.text = e.localizedDescription
                    print(e.localizedDescription)
                }else{
                    print("Succesfully Registered")
                    self.performSegue(withIdentifier: K.mainSegue, sender: self)
                }
            }
        }
    }
}
