//
//  POS.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class POS: NSObject {
    var name: String?
    var logo: String?
    var colorCode: String?
    var coupons: [Coupon] = []
    var peerID: String?
}