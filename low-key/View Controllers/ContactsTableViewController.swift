//
//  ContactsTableViewController.swift
//  low-key
//
//  Created by Eunice Oh on 11/28/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import Alamofire
import Foundation
import Firebase

class ContactsTableViewController: UITableViewController, CNContactPickerDelegate {
    
    var contacts = [PickedContact]()
    var selectedNumber:String = ""
    
    var AccoutSid = "AC4c54ed426d8623588135df369aa2020e"
    //ProcessInfo.processInfo.environment["TWILIO_ACCOUNT_SID"]
    var AuthToken = "a6cb9de3e3d9166d2cf9ce5e47b66f73"
    //ProcessInfo.processInfo.environment["TWILIO_AUTH_TOKEN"]
    var twilioNumber = "+13158430633" // change to Alphanumeric ID "low-key"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedContacts()
        //print("From viewDidLoad" + selectedNumber)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // implement contactPicker
    // add selected contacts to table view
    
    @IBAction func showContactPicker(_ sender: Any) {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    // allow user to PICK which contacts to add as a cell in table
    private func fetchedContacts() {
        
        // contains user's contacts database
        let store = CNContactStore();
        
        // asking for access from user
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                // fetches only given name, family name, and phone number of contact
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                
                // request object defines options/keys to use when fetching contacts
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    // returns boolean indicating if enumeration of all contacts matching fetch request executed successfully
                    // executes contact fetch request
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        self.contacts.append(PickedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? ""))
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    // numer of rows equal to number of items in contacts array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell.textLabel?.text = contacts[indexPath.row].firstName + " " + contacts[indexPath.row].lastName
        cell.detailTextLabel?.text = contacts[indexPath.row].telephone

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNumber = contacts[indexPath.row].telephone
        selectedNumber = selectedNumber.filter("0123456789.".contains)
        selectedNumber = "+1" + selectedNumber
        contactSelected()
        // transition to different view
        //transition()
    }
    
    func contactSelected() {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            
            let db = Firestore.firestore()
            
            db.collection("users").document(uid).getDocument { (document, error) in
                if error == nil {
                    let docData = document!.data()
                    let firstName = docData!["firstName"] as! String
                    let lastName = docData!["lastName"] as! String
                    //print(firstName + " " + lastName)
                    let name = firstName + " " + lastName
                    
                    let message = name + " is in a state of distress."
                    print(message)
                    
                    // using twilio api to send text
                    self.sendData(sender: self.selectedNumber, from: self.twilioNumber, body: message)
                    
                }
            }
        }
    }
    
    func sendData(sender: String, from: String, body: String) {
        let parameters: Parameters = [
            "To" : sender,
            "From" : from,
            "Body" : body
        ]
        
        AF.request("https://api.twilio.com/2010-04-01/Accounts/AC4c54ed426d8623588135df369aa2020e/Messages",
                   method: .post,
                   parameters: parameters
        ).authenticate(username: self.AccoutSid, password: self.AuthToken)
        .response { response in
            debugPrint(response)
        }
    }
}

/*
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

    // Configure the cell...

    return cell
}
*/

/*
// Override to support conditional editing of the table view.
override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
}
*/

/*
// Override to support editing the table view.
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        // Delete the row from the data source
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

}
*/

/*
// Override to support conditional rearranging of the table view.
override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
}
*/

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
