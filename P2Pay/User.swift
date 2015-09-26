//
//  User.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class User: NSObject, Typeable {
    var type = "user_identity"
    var name: String?
    var avatar: UIImage?
    let peerID: String
    
    init(peerID: String) {
        self.peerID = peerID
    }
    
    var data: NSDictionary {
        get {
            let imageData = UIImageJPEGRepresentation(avatar!, 60.0)
            let base64String = imageData!.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)
            return [
                "name" : self.name,
                "avatar" : base64String
            ]
        }
        
        set {
            
        }
    }

}
