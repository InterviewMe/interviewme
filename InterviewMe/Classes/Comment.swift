//
//  Comment.swift
//  InterviewMe
//
//  Created by Henry Vuong on 4/19/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import Foundation
import Parse

class Comment: PFObject, PFSubclassing {
    @NSManaged var user: PFUser?
    @NSManaged var date: String?
    @NSManaged var text: String?
    
    static func parseClassName() -> String {
        return "Comment"
    }
    
    class func comment(withPostText text: String?, withPost post: Post?, withCompletion completion: PFBooleanResultBlock?){
        let comment = Comment()
        
        comment.user = UserAccount.current()
        comment.text = text
        let formatter : DateFormatter = DateFormatter();
        formatter.dateFormat = "M/d/yy";
        let myStr : String = formatter.string(from: NSDate.init(timeIntervalSinceNow: 0) as Date);
        comment.date = myStr
        comment.saveInBackground(block: completion)
        
        let query = PFQuery(className: "Post")
        query.getObjectInBackground(withId: (post?.objectId)!) {
            (postObject: PFObject?, error: Error?) -> Void in
            if error != nil {
                print(error ?? "crap")
            } else if let postObject = postObject {
                post?.commentList.append(comment)
                postObject["commentList"] = post?.commentList
                postObject.saveInBackground()
                
            }
        }
        

    }
    
}
