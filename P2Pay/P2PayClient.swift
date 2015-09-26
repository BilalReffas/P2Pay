//
//  P2PClient.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

@objc
protocol MessagingDelegate {
    func didSendData(data: NSDictionary)
    optional func didReceivePOSIdentity(pos: POS)
    optional func didReceivePaymentRequest(paymentRequest: PaymentRequest)
}

class P2PayClient: NSObject {
    static let sharedInstance = P2PayClient()
    
    var delegate: MessagingDelegate?
    
    var pos: [POS] = []
    var me: User?
    
    func sendPaymentAcceptanceFor(paymentRequest: PaymentRequest, coupons: [Coupon]) {
        
    }
    
    func receiveData(data: NSDictionary) {
        guard let type: String = data["type"] as? String else {return}
        guard let data: NSDictionary = data["data"] as? NSDictionary else {return}
        if (type == "pos_identity") {
            let p = POS()
            p.name = data.valueForKeyPath("name") as? String
            p.colorCode = data.valueForKeyPath("color_code") as? String
            //p.avatar = data.valueForKeyPath("avatar") as? String
            if let coupons = data.valueForKeyPath("coupons") as? [NSDictionary] {
                for coupon in coupons {
                    let c = Coupon()
                    c.name          = coupon.valueForKeyPath("name") as? String
                    c.value         = coupon.valueForKeyPath("value") as? NSInteger
                    c.information   = coupon.valueForKeyPath("information") as? String
                    p.coupons.append(c)
                }
            }
            pos.append(p)
            delegate?.didReceivePOSIdentity!(p)
        } else if (type == "payment_request") {
            let paymentRequest = PaymentRequest()
            paymentRequest.uuid     = data.valueForKeyPath("uuid") as? String
            paymentRequest.amount   = data.valueForKeyPath("amount") as? Double
            paymentRequest.currency = data.valueForKeyPath("currency") as? String
            delegate?.didReceivePaymentRequest!(paymentRequest)
        }
    }
    
    func sendData(data: Serializable){
        /*let dic: [String:AnyObject] = [
            "type" : data.type,
            "data" : data.data
        ]
       delegate?.didSendData(dic)*/
    }
    
    
}
