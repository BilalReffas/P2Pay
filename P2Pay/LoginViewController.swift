//
//  LoginViewController.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate,GIDSignInDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = CGPointMake(self.view.center.x, self.view.center.y + 200 )
        self.view.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile"]
        loginButton.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "1031181075806-al8vdo83ftipiqnajs8mqm2ogun1uk9i.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().signOut()
        let button = GIDSignInButton()
        button.center = CGPointMake(self.view.center.x, self.view.center.y + 150)
        self.view.addSubview(button)
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            getUserID()
        }
        
        
    }
    
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                let userId = user.userID
                let idToken = user.authentication.idToken
                let name = user.profile.name
                let email = user.profile.email
                print("Sign in Successfull \(userId) \(idToken) \(name) \(email)")
                P2PayClient.sharedInstance.me?.facebookID = userId
                P2PayClient.sharedInstance.me?.name = name
                self.delay(0.5) {
                    self.performSegueWithIdentifier("openSearch", sender: self)
                }
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        if let error = error{
            print("\(error.localizedDescription)")
        }
    }
    
   
    
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getUserID()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            {
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
