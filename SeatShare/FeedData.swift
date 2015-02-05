//
//  FeedData.swift
//  SeatShare
//
//  Created by Michael McChesney on 2/3/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

let _mainData: FeedData = FeedData()

class FeedData: NSObject {
    
    var selectedVenue: [String:AnyObject]?
    
    var feedItems: [PFObject] = []
//    var myFeedItems: [PFObject] = []
   
    class func mainData() -> FeedData {
        
        return _mainData
    }
    
    // blocks are now called closures. completion: (parameter) -> (return -void if empty-)
    func refreshFeedItems(completion: () -> ()) {
        
        var feedQuery = PFQuery(className: "Seat")
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {
                
                self.feedItems = objects as [PFObject]
            
            }
            
            completion()
            
        }
        
    }
    
    func refreshMyFeedItems(completion: () -> ()) {
        
        var feedQuery = PFQuery(className: "Seat")
        
        feedQuery.whereKey("creator", equalTo: PFUser.currentUser())
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
//            if objects.count > 0 {
            
                self.feedItems = objects as [PFObject]
                
//            }
            
            completion()
            
        }
        
    }
    
}
