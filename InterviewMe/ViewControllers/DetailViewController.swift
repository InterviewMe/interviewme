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
 
 class DetailViewController: UIViewController {
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    var post: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let usernamePointer = post!["user"] as! UserAccount
        
        let usernameId = usernamePointer.value(forKey: "objectId") as! String
        let usernameQuery = PFUser.query()
        usernameQuery?.getObjectInBackground(withId: usernameId) {
            (usernameObject: PFObject?, error: Error?) -> Void in
            if error == nil {
                let firstName = usernameObject?.value(forKey: "first_name") as? String
                let lastName = usernameObject?.value(forKey: "last_name") as? String
                self.name.text = firstName! + " " + lastName!
                self.date.text = self.post!["date"] as? String
            } else {
                print("Error in retrieving username: \(error!)")
            }
        }
        comment.text = post!["text"] as? String
        //        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "GoToReply"){
            

            let CommentViewController = segue.destination as! CommentViewController
            CommentViewController.post = self.post as? Post
            
        }
    }
    
    
 }
