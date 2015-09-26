//
//  PaymentResponse.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class PaymentResponse: NSObject, Typeable {
    var type = "payment_response"
    
    var uuid: String?
    let coupons: [Coupon] = []
    
    var data: NSDictionary {
        get {
            return [
                "uuid" : uuid,
                "coupons" : coupons.map( { return $0.id })
            ]
        }
        
        set {
            
        }
        
    }
}
