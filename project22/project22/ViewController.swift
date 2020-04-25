//
//  ViewController.swift
//  project22
//
//  Created by N!no on 21/10/19.
//  Copyright © 2019 Abbott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: "Image")
    }
    
    @IBAction func OrderChangePage(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "OrderViewController") as? OrderViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    

    @IBAction func adminChangePage(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "AdminViewController") as? AdminViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}

