 
 //
 //  DetailViewController.swift
 //  InterviewMe
 //
 //  Created by Tianyu Liang on 4/19/18.
 //  Copyright © 2018 Somi Singh. All rights reserved.
 //
 
 import UIKit
 import Parse
 
 class DetailViewController: UIViewController {
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    var post: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let usernamePointer = post!["user"] as! UserAccount
        
        let usernameId = usernamePointer.value(forKey: "objectId") as! String
        let usernameQuery = PFUser.query()
        usernameQuery?.getObjectInBackground(withId: usernameId) {
            (usernameObject: PFObject?, error: Error?) -> Void in
            if error == nil {
                let firstName = usernameObject?.value(forKey: "first_name") as? String
                let lastName = usernameObject?.value(forKey: "last_name") as? String
                self.name.text = firstName! + " " + lastName!
                self.date.text = self.post!["date"] as? String
            } else {
                print("Error in retrieving username: \(error!)")
            }
        }
        comment.text = post!["text"] as? String
        //        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    
 }
