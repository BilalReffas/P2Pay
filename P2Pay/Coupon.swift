//
//  Coupon.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class Coupon: NSObject {
    enum CouponType {
        case Multiplication
        case Addidition
    }
    var id: String!
    var name: String!
    var value: Double!
    var information: String!
    var image: UIImage!
    var type: CouponType!
}
