//
//  User+CoreDataProperties.swift
//  Bundle
//
//  Created by Daniel Frost on 4/19/18.
//  Copyright © 2018 Bundle. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var location: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var profilephoto: NSData?

}
