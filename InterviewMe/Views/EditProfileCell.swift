//
//  EditProfileCell.swift
//  InterviewMe
//
//  Created by Henry Vuong on 5/18/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit

class EditProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var currentPositionLabel: UITextField!
    @IBOutlet weak var biographyTextField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // rounded corners for profile image
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderWidth = 0
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.borderColor = UIColor(red: 66/255, green: 207/255, blue: 175/255, alpha: 1).cgColor
        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
}
