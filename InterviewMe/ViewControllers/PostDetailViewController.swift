//
//  PostDetailViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 5/9/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit
import Parse

class PostDetailViewController: UITableViewController {

    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + post.comment_list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // cell returns post cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostCell", for: indexPath) as! DetailPostCell
            
            if post.user != nil {
                // User found! update username label with username
                let usernamePointer = post.value(forKey: "user") as! PFUser
                let usernameId = usernamePointer.value(forKey: "objectId") as! String
                let usernameQuery = PFUser.query()
                usernameQuery?.getObjectInBackground(withId: usernameId) {
                    (usernameObject: PFObject?, error: Error?) -> Void in
                    if error == nil {
                        
                        let firstName = usernameObject?.value(forKey: "first_name") as? String
                        let lastName = usernameObject?.value(forKey: "last_name") as? String
                        cell.name.text = firstName! + " " + lastName!
                        
                        // create the interval between the post date and the current date
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "M/d/yy"
                        
                        guard let postDate = dateFormatter.date(from: self.post["date"] as! String) else {
                            fatalError("ERROR: Date conversion failed due to mismatched format.")
                        }
                        
                        let today = Date()
                        let interval = today.interval(ofComponent: .day, fromDate: postDate)
                        if interval == 0 {
                            cell.date.text = "Today"
                        } else {
                            cell.date.text = String(interval) + "d"
                        }
                        
                        // get profile image
                        let profileImagePFFile = usernameObject?.value(forKey: "profile_image") as? PFFile
                        profileImagePFFile?.getDataInBackground(block: { (imageData: Data!, error: Error!) ->
                            Void in
                            if (error == nil) {
                                
                                cell.profileImageView.image = UIImage(data:imageData)
                                
                            }
                        })
                        
                        
                        // rounded corners for profile image
                        cell.profileImageView.layer.borderWidth = 1
                        cell.profileImageView.layer.masksToBounds = false
                        cell.profileImageView.layer.borderWidth = 0
                        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height / 2
                        cell.profileImageView.clipsToBounds = true
                        
                    } else {
                        print("Error in retrieving username: \(error!)")
                    }
                }
                cell.postText.text = post.text
                cell.commentCount.text = String(post.comment_count)
                cell.likeCount.text = String(post.like_count)
                cell.post = post
                
            } else {
                // No user found, set default username
                cell.name.text = "Couldn't retrieve name"
            }
            
            return cell
        } else if indexPath.row == 1 {
            // cell returns comment label separator
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentLabel", for: indexPath)

            return cell
        } else {
            // cell returns comments for post
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            
            // comment query
            let commentPointer = post.comment_list[indexPath.row - 2]
            let commentId = commentPointer.value(forKey: "objectId") as! String
            let commentQuery = Comment.query()
            commentQuery?.getObjectInBackground(withId: commentId) {
                (commentObject: PFObject?, error: Error?) -> Void in
                if error == nil {
                    cell.commentText.text = commentObject?.value(forKey: "text") as? String
                    
                    // comment query
                    let userPointer = commentObject?.value(forKey: "user") as! UserAccount
                    let userId = userPointer.value(forKey: "objectId") as! String
                    let userQuery = UserAccount.query()
                    userQuery?.getObjectInBackground(withId: userId) {
                        (userObject: PFObject?, error: Error?) -> Void in
                        if error == nil {
                            // user query
                            cell.name.text = (userObject?.value(forKey: "first_name") as? String)! + (userObject?.value(forKey: "last_name") as! String)
                            // get profile image
                            let profileImagePFFile = userObject?.value(forKey: "profile_image") as? PFFile
                            profileImagePFFile?.getDataInBackground(block: { (imageData: Data!, error: Error!) ->
                                Void in
                                if (error == nil) {
                                    
                                    cell.profileImageView.image = UIImage(data:imageData)
                                    
                                }
                            })
                        }
                    }
                } else {
                    // did not work
                }
            }
            
            /*
            cell.commentText.text = (commentList[indexPath.row - 2] as! Comment).text
            cell.name.text = ((commentList[indexPath.row - 2] as! Comment).user as! UserAccount).first_name + ((commentList[indexPath.row - 2] as! Comment).user as! UserAccount).last_name
            // get profile image
            let profileImagePFFile = ((commentList[indexPath.row - 2] as! Comment).user as! UserAccount).profile_image
            profileImagePFFile.getDataInBackground(block: { (imageData: Data!, error: Error!) ->
                Void in
                if (error == nil) {
                    
                    cell.profileImageView.image = UIImage(data:imageData)
                    
                }
            })*/
            
            return cell
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "GoToReplySegue"){
            
            
            let CommentViewController = segue.destination as! CommentViewController
            CommentViewController.post = post
            
        }
    }
}
