//
//  AdminSummaryViewController.swift
//  project22
//
//  Created by N!no on 22/10/19.
//  Copyright © 2019 Abbott. All rights reserved.
//

import UIKit
import CoreData

class AdminSummaryViewController: UIViewController {

    @IBOutlet weak var adminSummaryLabel: UITextView!
    override func viewDidLoad() {
    super.viewDidLoad()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    adminSummaryLabel.text = appDelegate.getOrderSummaryInfo()
    

}
    @IBAction func updateShift(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.removeSummaryRecords()
        adminSummaryLabel.text = appDelegate.getOrderSummaryInfo()
        
    }
    
}
