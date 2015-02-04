//
//  MyFeedTableViewController.swift
//  SeatShare
//
//  Created by Michael McChesney on 2/3/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class MyFeedTableViewController: FeedTableViewController {
   
    override func refreshFeed() {
        
        FeedData.mainData().refreshMyFeedItems { () -> () in
            // after the refreshFeedItems is finished, run this code
            self.tableView.reloadData()
            
        }
        
    }
    
}
