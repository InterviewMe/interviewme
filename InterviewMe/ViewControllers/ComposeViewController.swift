//
//  ComposeViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 4/8/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var postTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  @IBAction func didTapBackground(_ sender: Any) {
    postTextField.endEditing(true)
    view.endEditing(true)
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        Post.post(withPostText: postTextField.text, withCompletion: nil)
    }
    
}
