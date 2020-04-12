//
//  LoginViewController.swift
//  TODO Teste
//
//  Created by Vitor Hugo on 11/04/20.
//  Copyright © 2020 Vitor Hugo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKey()
        
        signinButton.layer.cornerRadius = 10.0
        signinButton.clipsToBounds = true
    }
    
    @IBAction func signinButtonPressed(_ sender: Any) {
        signIn()
    }
    
    
    // Signin
    func createUser() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            if let err = error {
                print(error?.localizedDescription)
            }
            else {
                print("User created successfully")
            }
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("User signs in successfully")
                let userInfo = Auth.auth().currentUser
                let email = userInfo?.email
                print(email)
                
                self.afterSuccessfulLogin()
                
                print("\(userInfo) has logged in!")
            }
        }
    }
    
    func afterSuccessfulLogin() {
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "NavigationPart")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

extension UIViewController {
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false; view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
