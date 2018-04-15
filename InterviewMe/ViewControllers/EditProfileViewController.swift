//
//  EditProfileViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 4/12/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UITextField!
    
    @IBOutlet weak var lastNameLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var biographyTextField: UITextView!
    
    var user = UserAccount.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateInfo()
        
        // tap to edit profile view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
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
                print(error ?? "crap")
            } else if let userObject = userObject {
                userObject["first_name"] = self.firstNameLabel.text
                userObject["last_name"] = self.lastNameLabel.text
                userObject["email"] = self.emailLabel.text
                userObject["username"] = self.emailLabel.text
                userObject["biography"] = self.biographyTextField.text
                userObject["profile_image"] = PFFile(name: "profile_image.png", data: UIImagePNGRepresentation(self.profileImageView.image!)!)
                userObject.saveInBackground()
                self.user = try! UserAccount.current()!.fetch()
                self.updateInfo()
            }
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
            // after it is completed
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Do something with the images (based on your use case)
        profileImageView.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func updateInfo() {
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
    
}
