//
//  Item+CoreDataProperties.swift
//  Bundle
//
//  Created by Daniel Frost on 4/23/18.
//  Copyright © 2018 Bundle. All rights reserved.
//
//

import Foundation
import CoreData


extension MarketplaceItem {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarketplaceItem> {
        return NSFetchRequest<MarketplaceItem>(entityName: "MarketplaceItem")
    }
    
    @NSManaged public var category: Int32
    @NSManaged public var condition: Int32
    @NSManaged public var desc: String?
    @NSManaged public var fragile: Bool
    @NSManaged public var image: NSData?
    @NSManaged public var name: String?
    @NSManaged public var oversized: Bool
    @NSManaged public var price: String?
    @NSManaged public var size: String?
    @NSManaged public var user: String?
    @NSManaged public var weight: Double
    @NSManaged public var location: String?
    @NSManaged public var uploaded: String?
    @NSManaged public var purchased: Bool

    

}
