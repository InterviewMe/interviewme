//
//  ProfileCell.swift
//  InterviewMe
//
//  Created by Henry Vuong on 5/22/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentPositionLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!

    var user = UserAccount.current()!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // rounded corners for profile image
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderWidth = 0
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
