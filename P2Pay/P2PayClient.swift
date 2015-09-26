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
    func willSendData(data: NSDictionary)
    optional func didReceivePOSIdentity(pos: POS)
    optional func didReceivePaymentRequest(paymentRequest: PaymentRequest)
}

class P2PayClient: NSObject {
    static let sharedInstance = P2PayClient()
    
    var delegate: MessagingDelegate?
    
    var pos: POS = POS()
    var me: User?
    
    func sendPaymentAcceptanceFor(paymentRequest: PaymentRequest, coupons: [Coupon]) {
        let paymentResponse = PaymentResponse()
        paymentResponse.coupons = coupons
        paymentResponse.uuid = paymentRequest.uuid
        paymentResponse.status = PaymentResponse.PaymentStatus.Accept
        self.sendData(paymentResponse)
    }
    
    func sendUserInformation() {
        if let me = self.me {
            self.sendData(me)
        }
    }
    
    func receiveData(data: NSDictionary) {
        guard let type: String = data["type"] as? String else {return}
        guard let data: NSDictionary = data["data"] as? NSDictionary else {return}
        if (type == "pos_identity") {
            pos.name = data.valueForKeyPath("name") as? String
            pos.colorCode = data.valueForKeyPath("color_code") as? String
            //p.avatar = data.valueForKeyPath("avatar") as? String
            if let coupons = data.valueForKeyPath("coupons") as? [NSDictionary] {
                for coupon in coupons {
                    let c = Coupon()
                    c.name          = coupon.valueForKeyPath("name") as? String
                    c.value         = coupon.valueForKeyPath("value") as? NSInteger
                    c.information   = coupon.valueForKeyPath("information") as? String
                    pos.coupons.append(c)
                }
            }
            delegate?.didReceivePOSIdentity!(pos)
        } else if (type == "payment_request") {
            let paymentRequest = PaymentRequest()
            paymentRequest.uuid     = data.valueForKeyPath("uuid") as? String
            paymentRequest.amount   = data.valueForKeyPath("amount") as? Double
            paymentRequest.currency = data.valueForKeyPath("currency") as? String
            delegate?.didReceivePaymentRequest!(paymentRequest)
        }
    }
    
    private func sendData(data: Serializable){
        let dic = NSDictionary()
        dic.setValue(data.type, forKey: "type")
        dic.setValue(data.data(), forKey: "data")
       delegate?.willSendData(dic)
    }
    
    
}
