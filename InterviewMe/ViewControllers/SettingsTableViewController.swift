//
//  SettingsTableViewController.swift
//  InterviewMe
//
//  Created by Henry Vuong on 4/4/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import UIKit
import Parse

class SettingsTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    @IBAction func signOutButton(_ sender: Any) {
        UserAccount.logOut()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }
}
