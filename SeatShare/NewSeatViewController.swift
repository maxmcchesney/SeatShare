//
//  NewSeatViewController.swift
//  SeatShare
//
//  Created by Michael McChesney on 2/3/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class NewSeatViewController: UIViewController {

//    var seats: [PFObject]?
    
    @IBOutlet weak var seatNameField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveSeat(sender: AnyObject) {
        
        // create PFObject and add it to seats
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        newSeat.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                println("newSeat saved")
            } else {
                println("error with saving newSeat")
            }
        }
        
        FeedData.mainData().feedItems.append(newSeat)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func cancelSeat(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func presentImagePicker(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.cameraDevice = .Rear
        imagePicker.showsCameraControls = true
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
