//
//  SignUpViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/6/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        // check all fields are filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        // check if password secure - regex
        return nil
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: "tabBarVC")
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // validate fields
        let error = validateFields()
        if error != nil {
          showError(error!)
        }
        else {
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showError("Error creating user")
                } else {
                    let db = Firestore.firestore()
                                    
                    let dataToSave:[String:String] = [
                        "firstName": firstName,
                         "lastName": lastName,
                         "userID": result!.user.uid
                        ]
                    
                    db.collection("users").document(result!.user.uid).setData(dataToSave) { (error) in
                        if error != nil {
                            self.showError("Error creating user data")
                        }
                    }
                    
                    // Save user's email and password locally to stay signed in
                    UserDefaults.standard.setValue(email, forKey: "userEmail")
                    UserDefaults.standard.setValue(password, forKey: "userPassword")
                    
                    // transition to home screen
                    self.transitionToHome()
                }
            }
        }

    }
    
    

    
}
