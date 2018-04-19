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
    @NSManaged var date: String?
    @NSManaged var text: String?
    @NSManaged var likeCount: Int
    @NSManaged var likeList: [PFUser]
    @NSManaged var commentCount: Int
    @NSManaged var commentList: [Comment]
    
    class func parseClassName() -> String {
        return "Post"
    }
    
    class func post(withPostText text: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = Post()
        
        post.user = UserAccount.current()
        post.text = text
        post.commentCount = 0
        let formatter : DateFormatter = DateFormatter();
        formatter.dateFormat = "M/d/yy";
        let myStr : String = formatter.string(from: NSDate.init(timeIntervalSinceNow: 0) as Date);
        post.date = myStr
        post.saveInBackground()
    }
}
