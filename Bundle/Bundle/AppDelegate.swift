//
//  AppDelegate.swift
//  Bundle
//
//  Created by Tyler Manning on 4/5/18.
//  Copyright © 2018 Bundle. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var model = MarketplaceItem()
    var userModel = User()
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController
        
        //check to see if password and email are in user defaults
        if (UserDefaults.standard.string(forKey: "email")) == nil {
            createMockData()
            //show login screen if the email key isn't present
            vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        } else {
            //show the initial view controller if email key is present
            vc = storyboard.instantiateInitialViewController()!
        }
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createMockData() {
//        let item1 = MPItem(Name: "Lion King VHS", Duration: "2 h ago", Location: "Cincinnati, OH", Price: "$100.00", ThumbNail: #imageLiteral(resourceName: "lion-king-vhs"), Description: exampleDesc)
//        let item2 = MPItem(Name: "Lamp", Duration: "18 h ago", Location: "Wilder, KY", Price: "$65.00", ThumbNail: #imageLiteral(resourceName: "lamp"), Description: exampleDesc)
//        let item3 = MPItem(Name: "Loveseat", Duration: "20 h ago", Location: "Oakley, OH", Price: "$500.00", ThumbNail: #imageLiteral(resourceName: "couch"), Description: exampleDesc)
//        let item4 = MPItem(Name: "Macbook Pro 13", Duration: "2 h ago", Location: "Colerain, OH", Price: "$1300.00", ThumbNail: UIImage(named: "macbook"), Description: exampleDesc)
//        let item5 = MPItem(Name: "bear & mountains tshirt", Duration: "18 h ago", Location: "Highland Heights, KY", Price: "$25.00", ThumbNail: UIImage(named: "tshirt"), Description: exampleDesc)
//        let item6 = MPItem(Name: "Chevrolet Equinox", Duration: "1 h ago", Location: "Mason, OH", Price: "$12000.00", ThumbNail: UIImage(named: "equinox"), Description: exampleDesc)
//        let item7 = MPItem(Name: "keurig coffee maker", Duration: "2 h ago", Location: "Erlanger, KY", Price: "$75.00", ThumbNail: UIImage(named: "keurig"), Description: exampleDesc)
//        let item8 = MPItem(Name: "awesome cat tent", Duration: "2 h ago", Location: "Batavia, OH", Price: "$5000.00", ThumbNail: UIImage(named: "cat-camp"), Description: exampleDesc)
//        let item9 = MPItem(Name: "tumbler", Duration: "2 h ago", Location: "Norwood, OH", Price: "$5.00", ThumbNail: UIImage(named: "tumbler"), Description: exampleDesc)
//        let item10 = MPItem(Name: "some painting", Duration: "2 h ago", Location: "Paris", Price: "$0.50", ThumbNail: UIImage(named: "mona"), Description: exampleDesc)
        
        var imageData =  UIImagePNGRepresentation(UIImage(named: "safariman")!)! as NSData
        userModel.registerUser(password: "safarijim", name: "Safari Jim", location: "Highland Heights, KY", email: "Safarijim@gmail.com", image: imageData)
        imageData = UIImagePNGRepresentation(UIImage(named: "mermaidman")!)! as NSData
        userModel.registerUser(password: "mermaidman", name: "Mermaid Man", location: "Bikini Bottom", email: "Mermaidman@gmail.com", image: imageData)
        
        var itemImage = UIImagePNGRepresentation(UIImage(named: "couch")!)! as NSData
        model.saveItem(category: 0, condition: 2, description: "cool couch", fragile: false, image: itemImage, name: "awesome couch", oversized: true, price: "$500.00", size: "oversized", user: "Safarijim@gmail.com", weight: 500, location: "Highland Heights, KY", uploaded: "April 24, 2018")
        itemImage = UIImagePNGRepresentation(UIImage(named: "cat-camp")!)! as NSData
        model.saveItem(category: 0, condition: 2, description: "this is a cool cat camp", fragile: false, image: itemImage, name: "CAT CAMP", oversized: true, price: "$10000.00", size: "oversized", user: "Mermaidman@gmail.com", weight: 5, location: "Bikini Bottom", uploaded: "April 23, 2018")
        itemImage = UIImagePNGRepresentation(UIImage(named: "tshirt")!)! as NSData
        model.saveItem(category: 0, condition: 2, description: "mountain tshirt", fragile: false, image: itemImage, name: "Moutain tshirt", oversized: false, price: "$25.00", size: "medium", user: "Mermaidman@gmail.com", weight: 500, location: "Bikini Bottom", uploaded: "April 25, 2018")
        itemImage = UIImagePNGRepresentation(UIImage(named: "mona")!)! as NSData
        model.saveItem(category: 0, condition: 2, description: "some painting i found somewhere", fragile: true, image: itemImage, name: "painting", oversized: false, price: "$0.50", size: "medium", user: "Safarijim@gmail.com", weight: 5, location: "Paris, FR", uploaded: "April 25, 2018")
        itemImage = UIImagePNGRepresentation(UIImage(named: "tumbler")!)! as NSData
        model.saveItem(category: 0, condition: 2, description: "coffee", fragile: false, image: itemImage, name: "tumbler", oversized: false, price: "$10.00", size: "small", user: "Mermaidman@gmail.com", weight: 5, location: "Oakley, OH", uploaded: "April 25, 2018")
        itemImage = UIImagePNGRepresentation(UIImage(named: "macbook")!)! as NSData
        model.saveItem(category: 0, condition: 2, description: "really really expensive", fragile: false, image: itemImage, name: "macbook pro 13", oversized: false, price: "$100.00", size: "small", user: "Safarijim@gmail.com", weight: 5, location: "Kenwood, OH", uploaded: "April 25, 2018")
        
        
    }
    
    
    
}


