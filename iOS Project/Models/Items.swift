//
//  Items.swift
//  iOS Project
//
//  Created by Ahsan Mughal on 27/04/2019.
//  Copyright © 2019 Ahsan Mughal. All rights reserved.
//

import Foundation
struct Items:Encodable,Decodable {
    var itemID: Int
    var resturantID: Int
    var itemName: String
    var itemPrice: Int
    
}
