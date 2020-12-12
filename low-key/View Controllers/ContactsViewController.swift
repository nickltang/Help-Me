//
//  ContactsViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/16/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import Contacts

/* class isn't connected to a view controller yet */

class ContactsViewController: UIViewController {

    // dummy variables
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    
    // not safe to store credentials on client app
    var AccoutSid = ProcessInfo.processInfo.environment["TWILIO_ACCOUNT_SID"]
    var AuthToken = ProcessInfo.processInfo.environment["TWILIO_AUTH_TOKEN"]
    var twilioNumber = "+13158430633" // change to Alphanumeric ID "low-key"
    var message = "(Name of person) is in a state of distress"
    
    @IBAction func sendData(_ sender: Any) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "To" : phoneNumberField.text ?? "",
            "From": twilioNumber,
            "Body": messageField.text ?? ""
        ]
        /*
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
        } */
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
