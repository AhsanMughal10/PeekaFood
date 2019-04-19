//
//  ResturantTableViewCell.swift
//  iOS Project
//
//  Created by Ahsan Mughal on 11/04/2019.
//  Copyright © 2019 Ahsan Mughal. All rights reserved.
//

import UIKit

class ResturantTableViewCell: UITableViewCell {

  
    @IBOutlet weak var resturantImage: UIImageView!
    
    @IBOutlet weak var ResturantLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
