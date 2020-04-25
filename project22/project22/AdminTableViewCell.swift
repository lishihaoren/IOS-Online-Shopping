//
//  AdminTableViewCell.swift
//  project22
//
//  Created by N!no on 21/10/19.
//  Copyright © 2019 Abbott. All rights reserved.
//

import UIKit

class AdminTableViewCell: UITableViewCell {

    @IBOutlet weak var adminImageView: UIImageView!
    @IBOutlet weak var adminNameLabel: UILabel!
    @IBOutlet weak var adminPriceLabel: UILabel!
    @IBOutlet weak var adminInfoLabel: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
