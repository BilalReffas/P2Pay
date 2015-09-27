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
        PPKControllerInitialized()
        PPKController.addObserver(self)
        
        self.delay(3.0){
            self.performSegueWithIdentifier("showCoupons", sender: nil)

        }
    }
    
    func p2pDiscoveryStateChanged(state: PPKPeer2PeerDiscoveryState) {
        if state == PPKPeer2PeerDiscoveryState.Running{
            print("Peer2Peer Is Running")
            PPKController.startP2PDiscoveryWithDiscoveryInfo("User".dataUsingEncoding(NSUTF8StringEncoding))
        }else if state == PPKPeer2PeerDiscoveryState.Stopped{
            print("Peer2Peer Is stopped")
        }else if state == PPKPeer2PeerDiscoveryState.Suspended{
            print("Peer2Peer Is suspended")
        }
    }
    
    func onlineMessagingStateChanged(state: PPKOnlineMessagingState) {
        if state == PPKOnlineMessagingState.Running{
            print("Messaging Is Running")
        }else if state == PPKOnlineMessagingState.Stopped{
            print("Messaging Is stopped")
        }else if state == PPKOnlineMessagingState.Suspended{
            print("Messaging Is suspended")
        }
        PPKControllerInitialized()
        
    }
    
    func p2pPeerDiscovered(peer: PPKPeer!) {
        if let discoveryInfo = peer.discoveryInfo {
            let discoveryInfoString = NSString(data: discoveryInfo, encoding:NSUTF8StringEncoding)
            guard let discoveryString = discoveryInfoString else {print("No DiscoveryString...");return}
            print("Is here with discovery info: \(peer.peerID) \(discoveryString)")
        }
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
            p2payClient.pos.peerID = peerID
            self.p2payClient.receiveData(dic)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func didReceivePOSIdentity(pos: POS) {
        p2payClient.sendUserInformation()
        self.performSegueWithIdentifier("openMain", sender: self)
    }
    
    func willSendData(data: NSDictionary) {
        do {
            let rawData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
            print(rawData)
            PPKController.sendMessage(rawData, withHeader: "", to: p2payClient.pos.peerID)
        } catch let error as NSError {
            print(error)
        }
    }
    

    
    
    func PPKControllerInitialized() {
        PPKController.startP2PDiscovery()
        PPKController.startOnlineMessaging()
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}
