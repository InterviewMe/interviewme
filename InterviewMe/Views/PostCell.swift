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

import UIKit
import Parse

protocol PostCellDelegate {
    func didTapProfileButton(user: UserAccount)
}

class PostCell: UITableViewCell, updateLikeDelegate {
    
    // cell elements

    
    @IBOutlet weak var profileButtonOutlet: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var currentPositionLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    var post: Post!
    var user: UserAccount!
    var delegate: PostCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    @IBAction func commentButton(_ sender: Any) {
    }
    
    func updateLike(likeCount: Int) {
        self.likeCount.text = String(likeCount)
    }
    
    @IBAction func profileButton(_ sender: Any) {
        delegate?.didTapProfileButton(user: user)
    }
    
    
}

