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
    @NSManaged var name: String?
    @NSManaged var date: NSDate?
    @NSManaged var text: String?
    @NSManaged var commentCount: Int
    
    class func parseClassName() -> String {
        return "Message"
    }
}
