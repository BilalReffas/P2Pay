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
    
    let pos: [POS] = []
    
    func receiveData(data: NSDictionary) {
        // Parse Data
    }
    
    func sendData(data: Serializable) {
        let dic: [String : AnyObject] = [
            "type" : data.type,
            "data" : data.data()
            ]
        delegate?.didSendData(dic)
    }
    
    
}
