//
//  PaymentResponse.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class PaymentResponse: NSObject, Serializable {
    enum PaymentStatus {
        case Accept
        case Decline
    }
    var uuid: String?
    var coupons: [Coupon] = []
    var status: PaymentStatus?
    
    var type: String = "payment_response"
    func data() -> NSDictionary {
        return NSDictionary()
    }
}
