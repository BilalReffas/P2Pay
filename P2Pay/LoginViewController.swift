//
//  LoginViewController.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController, FBSDKLoginButtonDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = CGPointMake(self.view.center.x, self.view.center.y + 200 )
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile"]
        loginButton.delegate = self
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            getUserID()
        }
    }
    
    func getUserID()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                P2PayClient.sharedInstance.me?.facebookID = result.valueForKey("id") as? String
                P2PayClient.sharedInstance.me?.facebookID = result.valueForKey("name") as? String
                self.delay(0.5) {
                    self.performSegueWithIdentifier("openSearch", sender: self)

                }
            }
        })
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        getUserID()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("logout")
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
