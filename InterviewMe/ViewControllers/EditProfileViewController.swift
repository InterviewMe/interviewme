//
//  EditProfileViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 4/12/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UITextField!
    
    @IBOutlet weak var lastNameLabel: UITextField!
    
    @IBOutlet weak var biographyTextField: UITextView!
    
    var user = UserAccount.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = user.first_name
        lastNameLabel.text = user.last_name
        user.profile_image.getDataInBackground(block: {
            (imageData: Data!, error: Error!) -> Void in
            if (error == nil) {
                self.profileImageView.image = UIImage(data:imageData)
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
    }
    
    
}
