//
//  FeedData.swift
//  SeatShare
//
//  Created by Michael McChesney on 2/3/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

// HW
// - DONE - add ids for parse (use my own for testing and will switch to class one tomorrow)
// - DONE - make the new seat PFObject saveInBackground
// - ~DONE - add a function to singleton that will query seats and update feedItems
// - DONE - connect login to Parse
// - DONE - add a button to new seat VC that will present an imagepicker and take a picture


import UIKit

let _mainData: FeedData = FeedData()

class FeedData: NSObject {
    
    var feedItems: [PFObject] = []
    
    

    func reloadFeed() {
        
        var query = PFQuery(className: "Seat")

        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) seats.")
                // Do something with the found objects
                for object in objects {
                    
                    self.feedItems.append(object as PFObject)
                    
                }
            } else {
                // Log details of the failure
                println("Error: %@ %@", error, error.userInfo!)
            }
        }
        
    }
    
    
    
    
    
    
    
    
   
    class func mainData() -> FeedData {
        
        return _mainData
    }

}
