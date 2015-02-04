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
        

        FeedData.mainData().reloadFeed()
        
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
        
        logInToParse()
     
    }
    
    func logInToParse() {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text

        PFUser.logInWithUsernameInBackground(user.username, password:user.password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                
                self.isLoggedIn = true
                println("Parse login successful for username: \(PFUser.currentUser().username).")
                self.leaveLogInVC()
                
            } else {
                
                // The login failed. Check error to see why.
                println("Parse login failed, signing up new user..")
                
                self.signUpToParse()
                
            }
        }
    }
    
    func signUpToParse() {

            var user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    // Hooray! Let them use the app now.
                    println("Parse sign up successfull, username: \(user.username) created.")
                    self.leaveLogInVC()
                } else {
                    // Show the errorString somewhere and let the user try again.
                    println("Parse sign in / up failed!")
                    // Add an alert for final sign in log in error!
                }
            }
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
            
            var currentUser = PFUser.currentUser()
            if currentUser != nil {
                
                // replace this controller with the tabbarcontroller
                leaveLogInVC()
                
            } else {
                // Show the signup or login screen
                return
            }

        }
        
    }
    
    func leaveLogInVC() {
        var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

