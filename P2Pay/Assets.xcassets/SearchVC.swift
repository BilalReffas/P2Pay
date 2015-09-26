//
//  SearchVC.swift
//  P2Pay
//
//  Created by Bilal Karim Reffas on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, PPKControllerDelegate,MessagingDelegate {

    let p2payClient = P2PayClient.sharedInstance
    var coupons : [Coupon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p2payClient.delegate = self
        PPKController.addObserver(self)
    }
    
    func p2pPeerDiscovered(peer: PPKPeer!) {
        let discoveryInfoString = NSString(data: peer.discoveryInfo, encoding:NSUTF8StringEncoding)
        guard let discoveryString = discoveryInfoString else {print("No DiscoveryString...");return}
        print("Is here with discovery info: \(peer.peerID) \(discoveryString)")
        p2payClient.pos.peerID = peer.peerID
    }
    
    func p2pPeerLost(peer: PPKPeer!) {
        print("Is no longer here 😞 \(peer.peerID)")
    }
    
    func didUpdateP2PDiscoveryInfoForPeer(peer: PPKPeer!) {
        let discoveryInfo = NSString(data: peer.discoveryInfo, encoding: NSUTF8StringEncoding)
        guard let discoveryString = discoveryInfo else {print("No DiscoveryInfo...");return}
        print("Has updated discovery info: \(peer.peerID) \(discoveryString)")
    }
    
    func messageReceived(messageBody: NSData!, header messageHeader: String!, from peerID: String!) {
        do {
            let dic = try NSJSONSerialization.JSONObjectWithData(messageBody, options: .AllowFragments) as! NSDictionary
            self.p2payClient.receiveData(dic)
        } catch _ {
            print("Error")
        }
    }
    
    func didReceivePOSIdentity(pos: POS) {
        self.performSegueWithIdentifier("openSearch", sender: self)
    }
    
    func willSendData(data: NSDictionary) {
        do {
            let rawData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
            PPKController.sendMessage(rawData, withHeader: nil, to: p2payClient.pos.peerID)
        } catch _ {
            print("Error")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ViewController
        vc.coupons = p2payClient.pos.coupons
    }
    

}
