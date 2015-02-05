//
//  NewSeatViewController.swift
//  SeatShare
//
//  Created by Michael McChesney on 2/3/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class NewSeatViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

//    var seats: [PFObject]?
    
    @IBOutlet weak var seatNameField: UITextField!
    @IBOutlet weak var seatImageView: UIImageView!
    
    @IBOutlet weak var selectVenueButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        imagePicker.sourceType = .Camera
        
        seatNameField.delegate = self


    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let venue = FeedData.mainData().selectedVenue {
            
            let venueName = venue["name"] as String
            selectVenueButton.setTitle(venueName + " (edit)", forState: .Normal)
            
        } else {
            
            selectVenueButton.setTitle("Select Venue", forState: .Normal)
        }
        
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        self.seatImageView.image = image

        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func resizeImage(image: UIImage, withSize size:CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    @IBAction func saveSeat(sender: AnyObject) {
        
        // create PFObject and add it to seats
        var newSeat = PFObject(className: "Seat")
        newSeat["name"] = seatNameField.text
        newSeat["creator"] = PFUser.currentUser()

        // get image to be smaller size
        // force unwrapping this for testing purposes - need to fix
        let image = resizeImage(seatImageView.image!, withSize: CGSizeMake(540, 540))    // 180 by 180 but with iphone 6 being 3x...
        
        // turn uiimage into pffrile and add to newseat
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name:"seat.png", data:imageData)
        newSeat["image"] = imageFile
        
        if let venue = FeedData.mainData().selectedVenue {
        
            newSeat["venue"] = venue
        
        }

        newSeat.saveInBackground()
        
        FeedData.mainData().feedItems.append(newSeat)
        
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
