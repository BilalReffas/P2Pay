//
//  User.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class User: NSObject, Serializable {
    
    let type = "user_identity"
    let name: String!
    let avatar: UIImage!
    
    init(name: String, avatar: UIImage) {
        self.name = name
        self.avatar = avatar
    }
    
    
    func data() -> NSDictionary {
        let imageData = UIImageJPEGRepresentation(avatar, 60.0)
        let base64String = imageData!.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)
        return [
            "name" : self.name,
            "avatar" : base64String
        ]
    }
}
