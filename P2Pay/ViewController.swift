//
//  ViewController.swift
//  P2Pay
//
//  Created by Bilal Karim Reffas on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PPKControllerDelegate {

    let p2payClient = P2PayClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        p2payClient.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func p2pPeerDiscovered(peer: PPKPeer!) {
        let discoveryInfoString = NSString(data: peer.discoveryInfo, encoding:NSUTF8StringEncoding)
        guard let discoveryString = discoveryInfoString else {print("No DiscoveryString...");return}
        print("Is here with discovery info: \(peer.peerID) \(discoveryString)")
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
        guard let messageText = NSString(data: messageBody, encoding: NSUTF8StringEncoding) else {return}
        let data = ["type" : "t"]
        p2payClient.receiveData(data)
    }
    
    func didSendData(data: NSDictionary) {
        PPKController.sendMessage(NSData(), withHeader: "", to: "")
    }
    
    
}

