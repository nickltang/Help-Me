//
//  ViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/6/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    public var userLoggedIn = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let email = UserDefaults.standard.string(forKey: "userEmail")
        let password = UserDefaults.standard.string(forKey: "userPassword")
        
        // sign in user
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { (result, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    self.transitionToHome()
                }
            }
    }
    
    func transitionToHome() {
        let homeVC = storyboard?.instantiateViewController(identifier: "tabBarVC")
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }

}
