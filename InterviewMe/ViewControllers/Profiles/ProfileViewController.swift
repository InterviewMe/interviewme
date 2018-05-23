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

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var user = UserAccount.current()!
    // refresh
    var refreshControl: UIRefreshControl!
    var cellDelegate: ProfileCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        // refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (FeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableview.insertSubview(refreshControl, at: 0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // pull to refresh
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        user = try! UserAccount.current()!.fetch()
        updateInfo()
        refreshControl.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        cellDelegate = cell
        updateInfo()
        return cell
    }
    
    func updateInfo() {
        cellDelegate.nameLabel.text = user.first_name + " " + user.last_name
        cellDelegate.biographyLabel.text = user.biography
        cellDelegate.cityLabel.text = user.city
        cellDelegate.currentPositionLabel.text = user.current_position
        
        user.profile_image.getDataInBackground(block: {
            (imageData: Data!, error: Error!) -> Void in
            if (error == nil) {
                self.cellDelegate.profileImageView.image = UIImage(data:imageData)
                
            }
        })
    }
    
    
}
