//
//  DetailPostCell.swift
//  InterviewMe
//
//  Created by Henry Vuong on 5/9/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit
import Parse

protocol updateLikeDelegate {
    func updateLike(likeCount: Int)
}

class DetailPostCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    var post: Post!
    var likeDelegate: JobCell?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButton(_ sender: Any) {
        
        if post.like_list.contains(UserAccount.current()!.value(forKey: "objectId")! as! String) {
            // unlike post
            let query = PFQuery(className: "Post")
            query.getObjectInBackground(withId: (post?.objectId)!) {
                (postObject: PFObject?, error: Error?) -> Void in
                if error != nil {
                    print(error ?? "crap")
                } else if let postObject = postObject {
                    
                    self.post.like_list.remove(at: self.post.like_list.index(of: (UserAccount.current()!.value(forKey: "objectId")! as! String))!)
                    self.post.like_count -= 1
                    postObject["like_list"] = self.post.like_list
                    postObject["like_count"] = self.post.like_count
                    postObject.saveInBackground()
                    
                    // update UI
                    self.likeCount.text = String(postObject["like_count"] as! Int)
                    // update UI for FeedView
                    self.likeDelegate?.updateLike(likeCount: self.post.like_count)
                    
                    
                }
            }
        } else {
            // like post
            let query = PFQuery(className: "Post")
            query.getObjectInBackground(withId: (post?.objectId)!) {
                (postObject: PFObject?, error: Error?) -> Void in
                if error != nil {
                    print(error ?? "crap")
                } else if let postObject = postObject {
                    self.post.like_list.append(UserAccount.current()!.value(forKey: "objectId")! as! String)
                    self.post.like_count += 1
                    postObject["like_list"] = self.post.like_list
                    postObject["like_count"] = self.post.like_count
                    postObject.saveInBackground()
                    
                    // update UI
                    self.likeCount.text = String(postObject["like_count"] as! Int)
                    
                    
                }
            }
        }
    }

}
