//
//  CouponsTVC.swift
//  P2Pay
//
//  Created by Bilal Karim Reffas on 27.09.15.
//  Copyright © 2015 Bilal Karim Reffas. All rights reserved.
//

import UIKit

class CouponsTVC: UITableViewController {
    @IBOutlet weak var cellRewe1: CouponCell!
    @IBOutlet weak var cellRewe2: CouponCell!
    @IBOutlet weak var cellRewe3: CouponCell!

    var selectedCoupon : NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0{
            cellRewe1.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else if cellRewe1.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cellRewe1.accessoryType = UITableViewCellAccessoryType.None
        }
        
        if indexPath.row == 1{
            cellRewe2.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else if cellRewe2.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cellRewe2.accessoryType = UITableViewCellAccessoryType.None
        }
        
        if indexPath.row == 2{
            cellRewe3.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else if cellRewe3.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cellRewe3.accessoryType = UITableViewCellAccessoryType.None
        }

    }
    
    
    


    


}
