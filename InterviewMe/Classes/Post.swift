/// Copyright (c) 2018 InterviewMe: Tianyu Liang, Somi Singh, Henry Vuong
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var user: PFUser?
    @NSManaged var date: String?
    @NSManaged var text: String?
    @NSManaged var like_count: Int
    // like_list will have string representation of the UserAccounts that have liked it
    @NSManaged var like_list: [String]
    @NSManaged var comment_count: Int
    @NSManaged var comment_list: [Comment]
    
    class func parseClassName() -> String {
        return "Post"
    }
    
    class func post(withPostText text: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = Post()
        
        post.user = UserAccount.current()
        post.text = text
        post.comment_count = 0
        post.comment_list = []
        post.like_count = 0
        post.like_list = []
        let formatter : DateFormatter = DateFormatter();
        formatter.dateFormat = "M/d/yy";
        let myStr : String = formatter.string(from: NSDate.init(timeIntervalSinceNow: 0) as Date);
        post.date = myStr
        post.saveInBackground(block: completion)
    }
}
