//
//  ProfileViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 4/4/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var currentPositionLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var biographyLabel: UILabel!
    
    
    var user = UserAccount.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        user = try! UserAccount.current()!.fetch()
        updateInfo()
    }

    func updateInfo() {
        nameLabel.text = user.first_name + " " + user.last_name
        emailLabel.text = user.email
        biographyLabel.text = user.biography
        
        user.profile_image.getDataInBackground(block: {
            (imageData: Data!, error: Error!) -> Void in
            if (error == nil) {
                self.profileImageView.image = UIImage(data:imageData)
                
            }
        })
    }
    

}
