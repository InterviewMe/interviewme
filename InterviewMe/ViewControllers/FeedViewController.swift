//
//  FeedViewController.swift
//  InterviewMe
//
//  Created by Tianyu Liang on 4/1/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

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
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
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
                self.refreshControl.endRefreshing();
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
    
    // This is just for display purpose. NEEDS TO BE DELTED once dynamic cell height is implemented
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobCell
        let post = posts[indexPath.row]
        
        
        if post["user"] != nil {
            // User found! update username label with username
            let usernamePointer = post.value(forKey: "user") as! PFUser
            let usernameId = usernamePointer.value(forKey: "objectId") as! String
            let usernameQuery = PFUser.query()
            usernameQuery?.getObjectInBackground(withId: usernameId) {
                (usernameObject: PFObject?, error: Error?) -> Void in
                if error == nil {
                    let firstName = usernameObject?.value(forKey: "first_name") as? String
                    let lastName = usernameObject?.value(forKey: "last_name") as? String
                    cell.name.text = firstName! + " " + lastName!
                    cell.date.text = post["date"] as? String
                } else {
                    print("Error in retrieving username: \(error!)")
                }
            }
            cell.textView.text = post["text"] as! String
            
        } else {
            // No user found, set default username
            cell.name.text = "gooby"
            cell.textView.text = post["text"] as! String
            
        }
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

