//
//  EditProfileViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 4/12/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UITextField!
    
    @IBOutlet weak var lastNameLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var biographyTextField: UITextView!
    
    var user = UserAccount.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = user.first_name
        lastNameLabel.text = user.last_name
        emailLabel.text = user.email
        biographyTextField.text = user.biography ?? ""
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
        let query = PFQuery(className:"_User")
        query.getObjectInBackground(withId: user.objectId!) {
            (userObject: PFObject?, error: Error?) -> Void in
            if error != nil {
                print(error)
            } else if let userObject = userObject {
                userObject["first_name"] = self.firstNameLabel.text
                userObject["last_name"] = self.lastNameLabel.text
                userObject["email"] = self.emailLabel.text
                userObject["username"] = self.emailLabel.text
                userObject["biography"] = self.biographyTextField.text
                userObject.saveInBackground()
            }
        }
    }
    
    
}
