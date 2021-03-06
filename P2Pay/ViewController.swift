//
//  ViewController.swift
//  P2Pay
//
//  Created by Bilal Karim Reffas on 26.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PPKControllerDelegate,MessagingDelegate,UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate{

    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let p2payClient = P2PayClient.sharedInstance
    var coupons : [Coupon] = []
    
    var selectedCoupon: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p2payClient.delegate = self
        PPKController.addObserver(self)
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func messageReceived(messageBody: NSData!, header messageHeader: String!, from peerID: String!) {
        guard let messageText = NSString(data: messageBody, encoding: NSUTF8StringEncoding) else {print("Empty");return}
        let data = ["type" : "t"]
        p2payClient.receiveData(data)
        print(messageText)
    }
    
    func willSendData(data: NSDictionary) {
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coupons.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedCoupon = indexPath.row
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : CouponCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CouponCell
        cell.nameLabel.text = self.coupons[indexPath.row].name
        cell.descriptionLabel.text = self.coupons[indexPath.row].information
        cell.couponTypeLabel.text = self.coupons[indexPath.row].type == Coupon.CouponType.Addidition ? "+\(self.coupons[indexPath.row].value)" : "X\(self.coupons[indexPath.row].value)"
        if let selectedCoupon = selectedCoupon {
            if (indexPath.row == selectedCoupon) {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        return cell
    }
    
    func didReceivePaymentRequest(paymentRequest: PaymentRequest) {
        UIAlertView(title: "Accept payment?", message: "Do you want to accept the payment of \(paymentRequest.currency) \(paymentRequest.amount)", delegate: self, cancelButtonTitle: "Decline", otherButtonTitles: "Accept").show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex)
    }
    
    
    
}

