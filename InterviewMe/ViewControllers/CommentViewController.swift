//
//  CommentViewController.swift
//  InterviewMe
//
//  Created by Tianyu Liang on 4/22/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit
import Parse

class CommentViewController: UIViewController {

    @IBOutlet weak var comment: UITextView!
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func comment(_ sender: Any) {
        Comment.comment(withPostText: comment.text, withPost: post) { (success, error) in
            if(success){
                print("posted")
                self.dismiss(animated: true, completion: nil)
                
            }else{
                print("failed")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
            
        
    }
    

}
