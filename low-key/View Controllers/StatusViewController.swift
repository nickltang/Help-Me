//
//  StatusViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/16/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    let moodData = ["Sad", "Happy", "Mad", "Pretty Savage", "≧◡≦", "(☆ᴗ☆ ◍)", "(⋆////⋆)", "( ͡👁️ ͜ʖ ͡👁️)", "(ㆆ_ㆆ)", "ↁ_ↁ", "(>.<)"]
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        // connects the data
        picker.delegate = self
        picker.dataSource = self
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
