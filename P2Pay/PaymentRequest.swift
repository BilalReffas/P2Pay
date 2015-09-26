//
//  PaymentRequest.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class PaymentRequest: NSObject, Typeable {
    var type = "payment_request"
    
    var data: NSDictionary {
        get {
           return NSDictionary()
        }
        
        set {
            
        }
    }
}
