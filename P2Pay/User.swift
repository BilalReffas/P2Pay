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
    var facebookID: String?
    let peerID: String
    
    init(peerID: String) {
        self.peerID = peerID
    }
    
    func data() -> NSDictionary {
        let dict = NSDictionary()
        dict.setValue(self.name, forKey: "name")
        dict.setValue(self.facebookID, forKey: "facebook_id")
        return dict
    }

}
