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
    
}
