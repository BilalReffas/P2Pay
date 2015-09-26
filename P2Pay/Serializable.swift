//
//  Serializer.swift
//  P2Pay
//
//  Created by Niklas Riekenbrauck on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

protocol Serializable {
    var type: String { get }
    func data() -> NSDictionary
}
