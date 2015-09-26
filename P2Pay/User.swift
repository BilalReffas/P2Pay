//
//  User.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class User: NSObject, Serializable {
    var type = "user_identity"
    var name: String?
    var avatar: UIImage?
    let peerID: String
    
    init(peerID: String) {
        self.peerID = peerID
    }
    
    func data() -> NSDictionary {
        return NSDictionary()
    }

}
