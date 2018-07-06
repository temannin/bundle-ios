//
//  Item+CoreDataClass.swift
//  Bundle
//
//  Created by Daniel Frost on 4/23/18.
//  Copyright © 2018 Bundle. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


public class MarketplaceItem: NSManagedObject {
    

    
    func setAsPurchased(item: MarketplaceItem) {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let managedContext = delegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MarketplaceItem")
            request.predicate = NSPredicate(format: "purchased == %@ AND name == %@", NSNumber(value: false), item.name!)
            request.returnsObjectsAsFaults = false
            do {
                let result = (try managedContext.fetch(request) as? [MarketplaceItem])!
                if (result.count != 0) {
                    result[0].setValue(true, forKey: "purchased")
                    try managedContext.save()
                }
            } catch {
                print("Failed loading from Core Data")
            }
        }
    }
    
    func fetchItems() -> [MarketplaceItem] {
        var items: [MarketplaceItem] = []
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let managedContext = delegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MarketplaceItem")
            request.predicate = NSPredicate(format: "purchased == %@", NSNumber(value: false))
            request.returnsObjectsAsFaults = false
            do {
                let result = (try managedContext.fetch(request) as? [MarketplaceItem])!
                items = result
            } catch {
                print("Failed loading from Core Data")
            }
        }
        return items
    }
    
    
    func fetchItemsForUser(email: String) -> [MarketplaceItem] {
        var items: [MarketplaceItem] = []
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let managedContext = delegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MarketplaceItem")
            request.predicate = NSPredicate(format: "user == %@", email)
            request.returnsObjectsAsFaults = false
            do {
                let result = (try managedContext.fetch(request) as? [MarketplaceItem])!
                items = result
            } catch {
                print("Failed loading from Core Data")
            }
        }
        return items
    }
    
 
    func saveItem(category: Int, condition: Int, description: String, fragile: Bool, image: NSData, name: String, oversized: Bool, price: String, size: String, user: String, weight: Double, location: String, uploaded: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let managedContext = appDelegate?.persistentContainer.viewContext {
            do {
                let entity = NSEntityDescription.entity(forEntityName: "MarketplaceItem", in: managedContext)
                let newItem = NSManagedObject(entity: entity!, insertInto: managedContext)
                newItem.setValue(category, forKey: "category")
                newItem.setValue(condition, forKey: "condition")
                newItem.setValue(description, forKey: "desc")
                newItem.setValue(fragile, forKey: "fragile")
                newItem.setValue(image, forKey: "image")
                newItem.setValue(name, forKey: "name")
                newItem.setValue(oversized, forKey: "oversized")
                newItem.setValue(price, forKey: "price")
                newItem.setValue(size, forKey: "size")
                newItem.setValue(user, forKey: "user")
                newItem.setValue(weight, forKey: "weight")
                newItem.setValue(location, forKey: "location")
                newItem.setValue(uploaded, forKey: "uploaded")
                newItem.setValue(false, forKey: "purchased")
                try managedContext.save()
                return true
            }
            catch {
                print("Failed to save item")
            }
        }
        return false
    }
}
