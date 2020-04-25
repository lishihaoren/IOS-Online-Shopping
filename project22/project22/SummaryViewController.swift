//
//  SummaryViewController.swift
//  project22
//
//  Created by N!no on 21/10/19.
//  Copyright © 2019 Abbott. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class SummaryViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    

    @IBOutlet weak var summaryLabel: UITextView!
    @IBOutlet weak var tableLabel: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var orderArray = [OrderSummary]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        summaryLabel.text = appDelegate.getOrderInfo()
        
        
    
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func canSendText() -> Bool {
    return MFMessageComposeViewController.canSendText()
    }
    
    
    @IBAction func confirmOrder(_ sender: Any) {
        
        let orderFood = OrderSummary(context: self.context)
        
        orderFood.orderSummary = summaryLabel.text
//        orderFood.table = tableLabel.text
//
//        self.orderArray.append(orderFood)
//        self.saveData()
        
        var textField = UITextField()
        //var textField1 = UITextField()
        let alert = UIAlertController(title: "Enter Table Number", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Submit", style: .default) { (action) in
//            let newItem = OrderSummary(context: self.context)

            orderFood.table = textField.text
            //orderFood.shift = textField1.text
            
            self.orderArray.append(orderFood)
            self.saveData()
            
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Table Number Here"
            textField = alertTextField
        }
        
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Shift Number Here"
//            textField1 = alertTextField
//        }
        present(alert, animated: true, completion: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.removeRecords();
        
        if MFMessageComposeViewController.canSendText(){
            let controller = MFMessageComposeViewController()
            controller.body = appDelegate.getOrderSummaryInfo()
            controller.recipients = ["0403274546", "123456789"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }else {
            print("SMS NOT Available")
        }
        
        
    
        
        
    }
    
    @IBAction func cancelOrder(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               appDelegate.removeRecords();
               self.summaryLabel.text = appDelegate.getOrderInfo()
        
    }
    
    
    func saveData() {
        do {
        try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    
}

