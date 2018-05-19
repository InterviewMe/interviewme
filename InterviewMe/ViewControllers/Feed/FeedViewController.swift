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

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    // tableView
  
    @IBOutlet weak var tableView: UITableView!
  
  
    var posts: [PFObject] = []
  
    // refresh
    var refreshControl: UIRefreshControl!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 170
        
    
        // refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (FeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0);
        updateMessage()
    }
  
    @IBAction func composeButton(_ sender: Any) {
    }
  
  
    // update display
    func updateMessage(){
    
        // construct PFQuery
        let query = PFQuery(className: "Post")
        
        query.order(byDescending: "createdAt")
        //query.includeKey("user")
        query.limit = 50
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts, error) in
          if posts != nil {
            // do something with the data fetched
            self.posts = posts!
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
          } else {
            // handle error
          }
        }
      }
  
    // pull to refresh
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        updateMessage();
    }
  
    // tableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return posts.count;
    }
    /*
    // This is just for display purpose. NEEDS TO BE DELTED once dynamic cell height is implemented
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300.0;//Choose your custom row height
    }*/
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
    
        if post["user"] != nil {
            // User found! update username label with username
            let usernamePointer = post.value(forKey: "user") as! UserAccount
            let usernameId = usernamePointer.value(forKey: "objectId") as! String
            let usernameQuery = PFUser.query()
            usernameQuery?.getObjectInBackground(withId: usernameId) {
                (usernameObject: PFObject?, error: Error?) -> Void in
                if error == nil {
                
                    let firstName = usernameObject?.value(forKey: "first_name") as? String
                    let lastName = usernameObject?.value(forKey: "last_name") as? String
                    cell.name.text = firstName! + " " + lastName!
                    cell.currentPositionLabel.text = usernameObject?.value(forKey: "current_position") as? String
            
                    // create the interval between the post date and the current date
            
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "M/d/yy"
                    
                    guard let postDate = dateFormatter.date(from: post["date"] as! String) else {
                        fatalError("ERROR: Date conversion failed due to mismatched format.")
                    }
            
                    let today = Date()
                    let interval = today.interval(ofComponent: .day, fromDate: postDate)
                    if interval == 0 {
                        cell.date.text = "Today"
                    } else {
                        cell.date.text = String(interval) + "d"
                    }

                    // get profile image
                    let profileImagePFFile = usernameObject?.value(forKey: "profile_image") as? PFFile
                    profileImagePFFile?.getDataInBackground(block: { (imageData: Data!, error: Error!) ->
                        Void in
                        if (error == nil) {
                    
                            cell.profileImageView.image = UIImage(data:imageData)
                            
                        }
                    })
                    
                    
                    // rounded corners for profile image
                    cell.profileImageView.layer.borderWidth = 1
                    cell.profileImageView.layer.masksToBounds = false
                    cell.profileImageView.layer.borderWidth = 0
                    cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height / 2
                    cell.profileImageView.clipsToBounds = true
                    
                } else {
                    print("Error in retrieving username: \(error!)")
                }
            }
            cell.postText.text = post["text"] as? String
            cell.commentCount.text = String(post["comment_count"] as! Int)
            cell.likeCount.text = String(post["like_count"] as! Int)
            
            cell.post = posts[indexPath.row] as? Post
            
        } else {
            // No user found, set default username
            cell.name.text = "Couldn't retrieve name"
        }
    
        return cell
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "PostDetailSegue"){
            let cell = sender as! PostCell
            let PostDetailViewController = segue.destination as! PostDetailViewController
            
            if let indexPath = tableView.indexPath(for: cell)
            {
                PostDetailViewController.post = posts[indexPath.row] as! Post
                PostDetailViewController.likeDelegate = tableView.cellForRow(at: indexPath) as? PostCell
            }
        }
    
    }
  
}

