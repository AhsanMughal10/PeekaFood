//
//  itemsImages.swift
//  iOS Project
//
//  Created by Ahsan Mughal on 29/04/2019.
//  Copyright © 2019 Ahsan Mughal. All rights reserved.
//

import Foundation
import UIKit
struct CustomItemImages {   // Custom Image class which holds an UIImage and a string as Its name
    var itemImageName:String
    var itemImage:UIImage
    init() {
        itemImageName=""
        itemImage=UIImage(named: "")!
    }
    init(imageName: String,image:UIImage) {
        itemImageName=imageName
        itemImage=image
    }
}
