//
//  JobCell.swift
//  InterviewMe
//
//  Created by Tianyu Liang on 4/1/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//


import UIKit
import Parse

class JobCell: UITableViewCell {
    
    // cell elements
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

