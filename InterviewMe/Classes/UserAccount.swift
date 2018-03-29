//
//  UserAccount.swift
//  InterviewMe
//
//  Created by Henry Vuong on 3/27/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import Foundation
import Parse

class UserAccount: PFUser {
    @NSManaged var first_name: String
    @NSManaged var last_name: String
    @NSManaged var biography: String ?? ""
    
    class func createAccount(email: String, password: String, first_name: String, last_name: String, withCompletion completion: PFBooleanResultBlock?) {
        // will migrate code to here later
    }
}
