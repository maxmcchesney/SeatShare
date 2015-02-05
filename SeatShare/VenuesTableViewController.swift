//
//  VenuesTableViewController.swift
//  SeatShare
//
//  Created by Michael McChesney on 2/5/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit
import CoreLocation

var onceToken: dispatch_once_t = 0

class VenuesTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var lManager = CLLocationManager()
    var foundVenues: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // TO ADD LOCATIONS / MAPS, DONT FORGET TO ADD LINE TO INFO.PLIST
        lManager.requestWhenInUseAuthorization()
        
        lManager.delegate = self
        
        lManager.startUpdatingLocation()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        dispatch_once(&onceToken) { () -> Void in
            
            if let location = locations.last as? CLLocation {
                
                // request to FourSquare for vendors with location
                self.foundVenues = FourSquareRequest.requestVenuesWithLocation(location)
                println(self.foundVenues)
                self.tableView.reloadData()
                
            }
        }
        
        lManager.stopUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return foundVenues.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        
        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        
        cell.textLabel?.text = venue["name"] as? String

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        
        // save the venue
        
        FeedData.mainData().selectedVenue = venue
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
