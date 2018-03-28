//
//  SignUpViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 3/27/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func signUpButton(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = emailTextField.text
        newUser.email = emailTextField.text
        newUser.password = passwordTextField.text
        
        // sign up function for PFUser
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error)
            } else {
                // create user account object
                let newUserAccount = UserAccount()
                newUserAccount.first_name = self.firstNameTextField.text!
                newUserAccount.last_name = self.lastNameTextField.text!
                newUserAccount.user = newUser
                newUserAccount.biography = ""
                newUserAccount.saveInBackground()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
