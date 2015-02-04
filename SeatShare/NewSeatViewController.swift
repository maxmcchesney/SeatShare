//
//  NewSeatViewController.swift
//  SeatShare
//
//  Created by Michael McChesney on 2/3/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class NewSeatViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    var seats: [PFObject]?
    
    @IBOutlet weak var seatNameField: UITextField!
    @IBOutlet weak var seatImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        imagePicker.sourceType = .Camera


    }
    
    
    @IBAction func takePicture(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        self.seatImageView.image = image

        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func saveSeat(sender: AnyObject) {
        
        // create PFObject and add it to seats
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        newSeat["creator"] = PFUser.currentUser()
        
        FeedData.mainData().feedItems.append(newSeat)
        
        
        newSeat.saveInBackground()
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func cancelSeat(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
