//
//  MoodCellTableViewCell.swift
//  low-key
//
//  Created by Gargi Tawde on 12/11/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import UIKit

class MoodCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateOfUpdateLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
