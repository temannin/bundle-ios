//
//  User+CoreDataClass.swift
//  Bundle
//
//  Created by Daniel Frost on 4/19/18.
//  Copyright © 2018 Bundle. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


public class User: NSManagedObject {
    
    func fetchUser(email: String) -> User {
        var user = User()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let managedContext = appDelegate?.persistentContainer.viewContext {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                request.returnsObjectsAsFaults = false
                request.predicate = NSPredicate(format: "email == %@", email)
                let result = (try managedContext.fetch(request) as? [User])
                if result?.count != 0  {
                    user = result![0]
                }
            }
            catch {
                print("Failed to fetch user")
            }
        }
        return user
    }
    
    func login(email: String, password: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let managedContext = appDelegate?.persistentContainer.viewContext {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                request.returnsObjectsAsFaults = false
                request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
                let result = (try managedContext.fetch(request) as? [User])
                if result?.count != 0  {
                    return true
                }
            }
            catch {
                print("Failed to fetch user")
            }
        }
        return false
    }
    
    func registerUser(password: String, name: String, location: String, email: String, image: NSData) -> Bool {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let managedContext = appDelegate?.persistentContainer.viewContext {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                request.returnsObjectsAsFaults = false
                request.predicate = NSPredicate(format: "email == %@", email)
                let result = (try managedContext.fetch(request) as? [User])
                if result?.count == 0  {
                    let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
                    let newUser = NSManagedObject(entity: entity!, insertInto: managedContext)
                    //save password as raw value now, eventually hash it
                    newUser.setValue(password, forKey: "password")
                    newUser.setValue(name, forKey: "name")
                    newUser.setValue(location, forKey: "location")
                    newUser.setValue(email, forKey: "email")
                    newUser.setValue(image, forKey: "profilephoto")
                    try managedContext.save()
                    return true
                }
            }
            catch {
                print("Failed to register user")
            }
        }
        return false
    }
    
    
    
}
