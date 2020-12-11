//
//  ProfileViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/6/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("profile loaded")
        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func onLogout(_ sender: Any) {
        do {
            // Sign out of firebaseAuth
            try Auth.auth().signOut()
            
            // Reset User Defaults
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            // Transition to login
            let loginVC = storyboard?.instantiateViewController(identifier: "loginVC")
            view.window?.rootViewController = loginVC
            view.window?.makeKeyAndVisible()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
