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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let email = UserDefaults.standard.string(forKey: "userEmail")
        let password = UserDefaults.standard.string(forKey: "userPassword")
        
        // sign in user
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { (result, error) in
            if error != nil {
            } else {
                // transition to home
//                let homeVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewCOntroller) as? HomeViewController
//                self.view.window?.rootViewController = homeVC
//                self.view.window?.makeKeyAndVisible()
                
                // transition to home screen
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
