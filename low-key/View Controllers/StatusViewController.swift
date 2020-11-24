//
//  StatusViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/16/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import Alamofire

class StatusViewController: UIViewController {
    
    
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    
    // not safe to store credentials on client app
    var AccoutSid = "AC4c54ed426d8623588135df369aa2020e"
    var AuthToken = "e326bf1a44d7e1408e3d4ecb0d2a6fb4"
    var twilioNumber = "+13158430633"
    
    @IBAction func sendData(_ sender: Any) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To" : phoneNumberField.text ?? "",
            "From": twilioNumber,
            "Body": messageField.text ?? ""
        ]
        
        AF.request("https://api.twilio.com/2010-04-01/Accounts/AC4c54ed426d8623588135df369aa2020e/Messages",
                   method: .post,
                   parameters: parameters
        ).authenticate(username: AccoutSid, password: AuthToken)
        .response { response in
            debugPrint(response)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
