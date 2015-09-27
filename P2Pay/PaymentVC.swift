//
//  PaymentVC.swift
//  P2Pay
//
//  Created by Bilal Karim Reffas on 27.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit
import LocalAuthentication

class PaymentVC: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    var myLocalizedReasonString : NSString = "Authentication is required for payment"
    let context : LAContext = LAContext()
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        authenticateUser()
    }
    
    func authenticateUser() {
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics,error: nil) {
            context.evaluatePolicy(
                LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Authentication is required for payment",
                reply: {(success, error) in
                    
                    if success{
                      print("Payment was successful!")
                      let alert = UIAlertController(title: "Successfull", message: "Payment was sended to Rewe Group", preferredStyle: UIAlertControllerStyle.Alert)
                        
                      let actionOne = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                        
                      })
                        alert.addAction(actionOne)
                        
                        dispatch_async(dispatch_get_main_queue()){
                          self.presentViewController(alert, animated: true, completion: nil)
                        }
                    }
                    
            })
        } else {
           print("TouchID not available not iDevice..")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func resetTouchID() {
    
        
    }

    @IBAction func cancelPressed(sender: AnyObject) {
        
    }

    @IBAction func checkmarkPressed(sender: AnyObject) {
        
    }

}
