//
//  PaymentResponse.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class PaymentResponse: NSObject, Serializable {
    enum PaymentStatus: String {
        case Accept = "accept"
        case Decline = "decline"
    }
    var uuid: String?
    var coupons: [Coupon] = []
    var status: PaymentStatus?
    
    var type: String = "payment_response"
    func data() -> Dictionary<String,AnyObject> {
        var dict = Dictionary<String,AnyObject>()
        dict["uuid"] = self.uuid
        dict["status"] = self.status?.rawValue
        dict["coupons"] = self.coupons.map({return $0.id})

        return dict
    }
}
