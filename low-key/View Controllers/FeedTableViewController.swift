//
//  FeedTableViewController.swift
//  low-key
//
//  Created by Gargi Tawde on 12/11/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit
import Firebase

class FeedTableViewController: UITableViewController {
    
    // posts array
    var moodArray = [String]()
    var dateArray = [String]()
    var profilePic: UIImage = UIImage()

    var nameOfUser = "NAME"

    override func viewDidLoad() {
        super.viewDidLoad()
        // getData()
        //print(moodArray)
        //self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        moodArray.removeAll()
        getData()
        self.tableView.reloadData()
    }
    
    
    func convertTimestamp(serverTimestamp: Double) -> String {
            let x = serverTimestamp / 1000
            let date = NSDate(timeIntervalSince1970: x)
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .medium

            return formatter.string(from: date as Date)
    }

    
    private func getData() {
        
        print("running getData")
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            let uid = user.uid
            
            // get name
            db.collection("users").document(uid).getDocument { (document, error) in
                if error == nil {
                    let docData = document!.data()
                    let firstName = docData!["firstName"] as! String
                    let lastName = docData!["lastName"] as! String
                    let pic = docData!["profilePicture"]
                    
                    print("TYPE OF SDFSDFSDF")
                    print(type(of: pic))
                    //print(pic)
                    
//                    if let imageData:NSData = pic.data(using: String.Encoding.utf8) as NSData?
//                    {
//                        let image = UIImage(data:imageData as Data,scale:1.0)
//                        self.profilePic = image!
//                    }
                    
                    //print(firstName + " " + lastName)
                    let name = firstName + " " + lastName
                    self.nameOfUser = name
                    
                    
                    DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                    
                    print(name)
                }
            }
            
            // get data
            db.collection("users").document(uid).collection("MoodCollection").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let docData = document.data()
                        let mood = docData["mood"] as! String
                        let date = docData["date"] as! Timestamp
                        
                        let datevalue = date.dateValue()
                        let df = DateFormatter()
                        df.dateFormat = "MM-dd-yyyy hh:mm"
                        let formattedDate = df.string(from: datevalue)
                    
                        // save data
                        self.moodArray.append(mood)
                        self.dateArray.append(formattedDate)
                        //print(mood)
                    }
                    
                    DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
            
                }
                //print("getting data: \(self.moodArray.count)")
            }
        }
    }

    
    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moodArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moodCell", for: indexPath) as! MoodCellTableViewCell
        
        if moodArray.count != 0 {
            cell.usernameLabel.text = nameOfUser
            cell.moodLabel.text = moodArray[indexPath.row]
            cell.dateOfUpdateLabel.text = dateArray[indexPath.row]
            //cell.profileImage.image = profilePic
        }
        
        print(moodArray)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0;//Choose your custom row height
    }


}
