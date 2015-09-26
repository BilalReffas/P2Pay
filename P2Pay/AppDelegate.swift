//
//  AppDelegate.swift
//  P2Pay
//
//  Created by Bilal Karim Reffas on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,PPKControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    PPKController.enableWithConfiguration("eyJzaWduYXR1cmUiOiJRdEVtb09vR3orci9ockI1WUFXTWxvLzh4MC9lY2xEd0M0bUhNcnRwWnJDRk55bStDcDEzeGpEYTNXM096S0taTHJxN0RMa0VDWUtpRTEwYU0ycytRR1RRVkYvWVhWZlk2Ni9xajJKZ2lyWjcxbVlnQ0ptVkV3bFNlSWFVUWlqWHFjZXN5VGYrYkEvQzNVWWp2UlRzZkZTRjhCRFJuNFBuY1IyaVFVUkNyTmc9IiwiYXBwSWQiOjEyNDMsInZhbGlkVW50aWwiOjE2NzkwLCJhcHBVVVVJRCI6IkFGRERCMkRFLTc4OTYtNDMxNC1BQjNDLTk4REIyRkU1MTdGRCJ9", observer: self)
    
        
    
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func p2pDiscoveryStateChanged(state: PPKPeer2PeerDiscoveryState) {
        if state == PPKPeer2PeerDiscoveryState.Running{
            print("Peer2Peer Is Running")
        }else if state == PPKPeer2PeerDiscoveryState.Stopped{
            print("Peer2Peer Is stopped")
        }else if state == PPKPeer2PeerDiscoveryState.Suspended{
            print("Peer2Peer Is suspended")
        }
    }
    
    func onlineMessagingStateChanged(state: PPKOnlineMessagingState) {
        if state == PPKOnlineMessagingState.Running{
            print("Messaging Is Running")
            PPKController.sendMessage("hallo slex du spasst".dataUsingEncoding(NSUTF8StringEncoding), withHeader: "", to: "647bfb57-bf33-44d9-96be-44756d656e69")
        }else if state == PPKOnlineMessagingState.Stopped{
            print("Messaging Is stopped")
        }else if state == PPKOnlineMessagingState.Suspended{
            print("Messaging Is suspended")
        }
    }
    
    
    func PPKControllerInitialized() {
        PPKController.startP2PDiscovery()
        PPKController.startOnlineMessaging()
        PPKController.startP2PDiscoveryWithDiscoveryInfo("Aley jetzt Info".dataUsingEncoding(NSUTF8StringEncoding))
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    func PPKControllerFailedWithError(error: NSError!) {
        print("\(error.localizedDescription)")
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

