//
//  ProfileViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/6/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userProfileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func onProfilePicture(_ sender: Any) {
        print("Tapped")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 110, height: 110)
        let scaledImage = image.af_imageScaled(to: size)
        let roundedImage = scaledImage.af_imageRoundedIntoCircle()
        userProfileImage.image = roundedImage
        
        // Upload image to firestore
        let imageData = roundedImage.pngData()
        
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        var userId = ""
        if let user = currentUser {
            userId = currentUser!.uid
        }
                        
        let dataToSave:[String:Any] = [
            "profilePicture": imageData!
            ]
        
        print(userId)
        print(currentUser?.displayName)
        
        db.collection("users").document(userId).setData(dataToSave, merge: true) { (error) in
            if error != nil {
                debugPrint(error?.localizedDescription)
            } else {
                print("Success writing data")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
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
