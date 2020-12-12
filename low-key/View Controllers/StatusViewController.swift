//
//  StatusViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/16/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import Firebase

class StatusViewController: UIViewController {

    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    let moodData = ["Sad", "Happy", "Mad", "Pretty Savage", "≧◡≦", "(☆ᴗ☆ ◍)", "(⋆////⋆)", "( ͡👁️ ͜ʖ ͡👁️)", "(ㆆ_ㆆ)", "ↁ_ↁ", "(>.<)"]
    
    let db = Firestore.firestore()
            
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
//        // connects the data
        picker.delegate = self
        picker.dataSource = self
    }

    @IBAction func saveData(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            let uid = user.uid
            //let docRef = db.collection("users").document(uid)
                        
            let moodData: [String:Any] = [
                "mood": moodLabel.text ?? "",
                "date": Timestamp(date: Date())
            ]
            
            db.collection("users").document(uid).collection("MoodCollection").addDocument(data: moodData) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document sucessfully written!")
                    }
            }
            
        }
    }
    
}

extension StatusViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moodData.count
    }
    
    
}

extension StatusViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moodData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
        moodLabel.text = moodData[row]
    }
    
    
}
