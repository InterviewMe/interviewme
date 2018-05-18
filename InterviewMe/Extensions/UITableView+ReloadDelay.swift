//
//  UITableView+ReloadDelay.swift
//  InterviewMe
//
//  Created by Henry Vuong on 5/18/18.
//  Copyright © 2018 Somi Singh. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    // Default delay time = 0.5 seconds
    // Pass delay time interval, as a parameter argument
    func reloadDataAfterDelay(delayTime: TimeInterval = 0.5) -> Void {
        self.perform(#selector(self.reloadData), with: nil, afterDelay: delayTime)
    }
    
}
