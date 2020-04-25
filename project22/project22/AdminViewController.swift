//
//  adminViewController.swift
//  project22
//
//  Created by N!no on 21/10/19.
//  Copyright © 2019 Abbott. All rights reserved.
//

import UIKit
import CoreData

class AdminViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var adminTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchController : NSFetchedResultsController<Food>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminTableView.delegate = self
        adminTableView.dataSource = self
        
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
            return "Add Foods"
        }
        
        let title = sectionInfo.name
        
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchController.sections?[section].numberOfObjects ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminCell", for: indexPath) as! AdminTableViewCell
        
        let entity = fetchController.object(at: indexPath)
        
        if let foodImage = entity.image{
            cell.adminImageView.image = UIImage(data: foodImage as Data)
        }
        
        cell.adminNameLabel.text = entity.name
        cell.adminPriceLabel.text = entity.price
        cell.adminInfoLabel.text = entity.info
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        var name1TextField = UITextField()
        var price1TextField = UITextField()
        var info1TextField = UITextField()
        let alert = UIAlertController(title: "Change New Food", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Food", style: .default) { (action) in

            self.fetchController.object(at: indexPath).setValue(name1TextField.text, forKeyPath: "name")
            self.fetchController.object(at: indexPath).setValue(price1TextField.text, forKeyPath: "price")
            self.fetchController.object(at: indexPath).setValue(info1TextField.text, forKeyPath: "info")


            self.saveData()
            self.loadData()
        }
        alert.addAction(action)
        alert.addTextField { (bukTextField) in
            bukTextField.placeholder = "Food Name Here"
            name1TextField = bukTextField
        }
        alert.addTextField { (dolarTextField) in
            dolarTextField.placeholder = "Food Price Here"
            price1TextField = dolarTextField
        }
        alert.addTextField { (mationTextField) in
            mationTextField.placeholder = "Food Description Here"
            info1TextField = mationTextField
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    @IBAction func addFood(_ sender: Any){
        
        let imagePicker = UIImagePickerController()
                      imagePicker.sourceType = .photoLibrary
                      imagePicker.delegate = self
                      self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            picker.dismiss(animated: true, completion: nil)
            self.createPresentItem(with : image)
        }
    }
    
    func createPresentItem (with image:UIImage){
        
        
        let presentItem = Food(context: context)
        presentItem.image = NSData(data: image.jpegData(compressionQuality: 0.3)!) as Data
        
        

        var categoryTextField = UITextField()
        var nameTextField = UITextField()
        var priceTextField = UITextField()
        var infoTextField = UITextField()
        let alert = UIAlertController(title: "Create New ListItem", message: "", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//
//
//            presentItem.name = textField.text
////            self.listItemArray.append(newItem)
////            self.saveData()
//        }
        //alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item Here"
            categoryTextField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item Here"
            nameTextField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item Here"
            priceTextField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item Here"
            infoTextField = alertTextField
        }

//        let alert = UIAlertController(title: "Create New Food", message: "", preferredStyle: .alert)
//
//
//        alert.addTextField { (categoryTextField) in
//            categoryTextField.placeholder = "Food Category Here"
//
//        }
//        alert.addTextField { (nameTextField) in
//            nameTextField.placeholder = "Food Name Here"
//
//        }
//        alert.addTextField { (priceTextField) in
//            priceTextField.placeholder = "Food Price Here"
//
//        }
//        alert.addTextField { (infoTextField) in
//            infoTextField.placeholder = "Food Description Here"
//
//        }
//
        alert.addAction(UIAlertAction(title: "Add Food", style: .default, handler: {(action:UIAlertAction) in
            presentItem.category = categoryTextField.text
            presentItem.name = nameTextField.text
            presentItem.price = priceTextField.text
            presentItem.info = infoTextField.text
//
//            let categoryTextField = alert.textFields?.first
//            let nameTextField = alert.textFields?.last
//            let priceTextField = alert.textFields?.first
//            let infoTextField = alert.textFields?.last
//
//
//            presentItem.category = categoryTextField?.text
//            presentItem.name = nameTextField?.text
//            presentItem.price = priceTextField?.text
//            presentItem.info = infoTextField?.text
            
        
    
                
        
        do {
            try self.context.save()
            self.loadData()
        }catch{
             print("Error Saving Context \(error)")
        }
            
        }
            
    )
    )
        adminTableView.reloadData()
    
        self.present(alert, animated: true, completion: nil)
    }
        
        
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error Saving Context \(error)")
        }
        adminTableView.reloadData()
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
        adminTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let item = fetchController.object(at: indexPath)
            context.delete(item)
        }
        
        saveData()
        loadData()

    }
    
    
    @IBAction func viewOrder(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "AdminSummaryViewController") as? AdminSummaryViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
//    @IBAction func viewShift(_ sender: Any) {
//        
//        let vc = storyboard?.instantiateViewController(identifier: "ShiftSummaryViewController") as? ShiftSummaryViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
//
//    }
    
    
    
}
