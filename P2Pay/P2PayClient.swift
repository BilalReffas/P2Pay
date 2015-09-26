//
//  P2PClient.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

protocol MessagingDelegate {
    func didSendData(data: NSDictionary)
}

class P2PayClient: NSObject {
    static let sharedInstance = P2PayClient()
    
    var delegate: MessagingDelegate?
    
    var pos: [POS] = []
    var me: User?
    
    func receiveData(data: NSDictionary) {
        guard let type: String = data["type"] as? String else {return}
        guard let data: NSDictionary = data["data"] as? NSDictionary else {return}
        if (type == "pos_identity") {
            let p = POS()
            p.name = data["name"] as? String
            //p.avatar = data["avatar"] as? String
            
            pos.append(p)
        } else if (type == "payment_request") {
            
        }
    }

    
    func sendData(data: Typeable) {
        let dic: [String : AnyObject] = [
            "type" : data.type,
            "data" : data.data
            ]
        delegate?.didSendData(dic)
    }
    
    
}
