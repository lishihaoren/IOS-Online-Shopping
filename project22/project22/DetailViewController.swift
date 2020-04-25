//
//  DetailViewController.swift
//  project22
//
//  Created by N!no on 21/10/19.
//  Copyright © 2019 Abbott. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailInfoLabel: UITextView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var cartArray = [Order]()
    
    var getName = String()
    var getImage = UIImage()
    var getInfo = String()
    var getPrice = String()
    
    override func viewDidLoad() {
           super.viewDidLoad()
        detailImageView.image = getImage
        detailInfoLabel.text = getInfo
        detailNameLabel.text = getName
        detailPriceLabel.text = getPrice
       }
    
    
    @IBAction func addToCart(_ sender: Any) {
        
        let cartFood = Order(context: self.context)
        
        cartFood.orderName = detailNameLabel.text
        cartFood.orderPrice = detailPriceLabel.text
        
        self.cartArray.append(cartFood)
        self.saveData()
        
        let alert = UIAlertController(title: "Message", message: "Order successfull!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveData() {
        do {
        try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    
    
    
}
