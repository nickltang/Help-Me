//
//  LoginViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/6/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: "tabBarVC")
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // validate text fields
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        // sign in user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {

                
                // Save user's email and password locally so they can stay signed in
                UserDefaults.standard.setValue(email, forKey: "userEmail")
                UserDefaults.standard.setValue(password, forKey: "userPassword")
                // transition to home
//                let homeVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewCOntroller) as? HomeViewController
//                self.view.window?.rootViewController = homeVC
//                self.view.window?.makeKeyAndVisible()
                
                // transition to home screen
                self.transitionToHome()

            }
        }
        
    }
    

}
