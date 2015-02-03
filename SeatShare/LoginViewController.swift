//
//  ViewController.swift
//  SeatShare
//
//  Created by Michael McChesney on 2/3/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfLoggedIn()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                
                self.buttonBottomConstraint.constant = 20 + kbSize.height
                
                // used to animate constraint
                self.view.layoutIfNeeded()
                
            }
            
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
                
                self.buttonBottomConstraint.constant = 20
            
            // used to animate constraint
                self.view.layoutIfNeeded()
        
        }
        
    }
    
    
    
    @IBAction func loginRegister(sender: AnyObject) {
    
        isLoggedIn = true
        
        checkIfLoggedIn()
        
        
    }
    
    var isLoggedIn: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn")
        }
        
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "isLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func checkIfLoggedIn() {
        
        if isLoggedIn {
            
            var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
            
            // replace this controller with the tabbarcontroller
            
        }
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

