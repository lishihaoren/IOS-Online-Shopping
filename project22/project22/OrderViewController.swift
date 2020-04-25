//
//  OrderViewController.swift
//  project22
//
//  Created by N!no on 21/10/19.
//  Copyright © 2019 Abbott. All rights reserved.
//

import UIKit
import CoreData

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var orderTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchController : NSFetchedResultsController<Food>!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
         orderTableView.delegate = self
               orderTableView.dataSource = self
               
               loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            loadData()
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            if let frc = fetchController {
                return frc.sections!.count
            }
            return 1
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            guard let sectionInfo = fetchController?.sections?[section] else {
                return "Add Items"
            }
            
            let title = sectionInfo.name
            
            return title
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return fetchController.sections?[section].numberOfObjects ?? 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
            
            let entity = fetchController.object(at: indexPath)
            
            if let foodImage = entity.image{
                cell.orderImageView.image = UIImage(data: foodImage as Data)
            }
            
            cell.orderNameLabel.text = entity.name
            cell.orderPriceLabel.text = entity.price
            cell.orderInfoLabel.text = entity.info
            
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
                       
            let entity = fetchController.object(at: indexPath)
            
            let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
            
            if let detailImage = entity.image{
                vc?.getImage = UIImage(data: detailImage as Data)!
            }
            
            vc?.getName = entity.name!
            vc?.getPrice = entity.price!
            vc?.getInfo = entity.info!
            
            self.navigationController?.pushViewController(vc!, animated: true)

        
        }
        
        
        func saveData() {
            do {
                try context.save()
            } catch {
                print("Error Saving Context \(error)")
            }
            orderTableView.reloadData()
        }
    
        
        func loadData() {
            let request = NSFetchRequest<Food>(entityName: "Food")
            let sort = NSSortDescriptor(key: "category", ascending: true)
            request.sortDescriptors = [sort]
            fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "category", cacheName: nil)
            
            do {
                try fetchController.performFetch()
            } catch {
                print("Error loading data \(error)")
            }
            orderTableView.reloadData()
        }
    


    @IBAction func orderFood(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SummaryViewController") as? SummaryViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
