//
//  MarketplaceItem.swift
//  Bundle
//
//  Created by Daniel Frost on 4/16/18.
//  Copyright © 2018 Bundle. All rights reserved.
//

import Foundation
import UIKit

class MPItem {
    var itemName: String?
    var duration: String?
    var location: String?
    var price: String?
    var thumbnail: UIImage?
    var description: String?
    
    init(Name: String?, Duration: String?, Location: String?, Price: String?, ThumbNail: UIImage?, Description: String?) {
        itemName = Name
        duration = Duration
        location = Location
        price = Price
        thumbnail = ThumbNail
        description = Description
    }
    
}
