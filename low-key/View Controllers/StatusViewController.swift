//
//  StatusViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/16/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class StatusViewController: UIViewController {
    
    
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    
    // not safe to store credentials on client app
    var AccoutSid = ProcessInfo.processInfo.environment["TWILIO_ACCOUNT_SID"] 
    var AuthToken = ProcessInfo.processInfo.environment["TWILIO_AUTH_TOKEN"]
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
        
        if AccoutSid != nil && AuthToken != nil {
            AF.request("https://api.twilio.com/2010-04-01/Accounts/AC4c54ed426d8623588135df369aa2020e/Messages",
                       method: .post,
                       parameters: parameters
            ).authenticate(username: AccoutSid!, password: AuthToken!)
            .response { response in
                debugPrint(response)
            }
        } else {
            print("AccountSid and/or AuthToken are nil")
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
