//
//  Post.swift
//  InterviewMe
//
//  Created by Tianyu Liang on 4/1/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import Foundation
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var user: PFUser?
    @NSManaged var date: NSDate?
    @NSManaged var text: String?
    @NSManaged var commentCount: Int
    
    class func parseClassName() -> String {
        return "Post"
    }
    
    class func post(withPostText text: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = Post()
        
        post.user = UserAccount.current()
        post.text = text
        post.commentCount = 0
        post.saveInBackground()
    }
}
