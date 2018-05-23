//
//  OtherProfileViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 5/23/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit

class OtherProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user: UserAccount!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherProfileCell") as! OtherProfileCell
        
        cell.nameLabel.text = user.first_name + " " + user.last_name
        cell.biographyLabel.text = user.biography
        cell.cityLabel.text = user.city
        cell.currentPositionLabel.text = user.current_position
        
        user.profile_image.getDataInBackground(block: {
            (imageData: Data!, error: Error!) -> Void in
            if (error == nil) {
                cell.profileImageView.image = UIImage(data:imageData)
                
            }
        })
        
        return cell
    }
}
