//
//  ProfileViewController.swift
//  Bundle
//
//  Created by Jordan Crandall on 4/24/18.
//  Copyright © 2018 Bundle. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data = [MPItem]()
    var items = [MarketplaceItem]()
    let model = MarketplaceItem()
    let userModel = User()
    var user = User()
    var DetailsDelegate: MarketplaceItemDelegate?
    let cellReuseIdentifier = "userCell"
    var exampleDesc = "This is a test description to show how the Detail View controller handles text in the scrollable text view. Lorep Ipsum Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblLocation: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUserItems()
        fetchUserInformation()
        populateDetails()
        ///////////  Temporary: Manually Inserting Items   //////////
        
        let item1 = MPItem(Name: "Lion King VHS", Duration: "2 h ago", Location: "Cincinnati, OH", Price: "$100.00", ThumbNail: #imageLiteral(resourceName: "lion-king-vhs"), Description: exampleDesc)
        let item2 = MPItem(Name: "Lamp", Duration: "18 h ago", Location: "Wilder, KY", Price: "$65.00", ThumbNail: #imageLiteral(resourceName: "lamp"), Description: exampleDesc)
        let item3 = MPItem(Name: "Loveseat", Duration: "20 h ago", Location: "Oakley, OH", Price: "$500.00", ThumbNail: #imageLiteral(resourceName: "couch"), Description: exampleDesc)
        let item4 = MPItem(Name: "Macbook Pro 13", Duration: "2 h ago", Location: "Colerain, OH", Price: "$1300.00", ThumbNail: UIImage(named: "macbook"), Description: exampleDesc)
        let item5 = MPItem(Name: "bear & mountains tshirt", Duration: "18 h ago", Location: "Highland Heights, KY", Price: "$25.00", ThumbNail: UIImage(named: "tshirt"), Description: exampleDesc)
        let item6 = MPItem(Name: "Chevrolet Equinox", Duration: "1 h ago", Location: "Mason, OH", Price: "$12000.00", ThumbNail: UIImage(named: "equinox"), Description: exampleDesc)
        let item7 = MPItem(Name: "keurig coffee maker", Duration: "2 h ago", Location: "Erlanger, KY", Price: "$75.00", ThumbNail: UIImage(named: "keurig"), Description: exampleDesc)
        let item8 = MPItem(Name: "awesome cat tent", Duration: "2 h ago", Location: "Batavia, OH", Price: "$5000.00", ThumbNail: UIImage(named: "cat-camp"), Description: exampleDesc)
        let item9 = MPItem(Name: "tumbler", Duration: "2 h ago", Location: "Norwood, OH", Price: "$5.00", ThumbNail: UIImage(named: "tumbler"), Description: exampleDesc)
        let item10 = MPItem(Name: "some painting", Duration: "2 h ago", Location: "Paris", Price: "$0.50", ThumbNail: UIImage(named: "mona"), Description: exampleDesc)
        
        data.append(item1)
        data.append(item2)
        data.append(item3)
        data.append(item4)
        data.append(item5)
        data.append(item6)
        data.append(item7)
        data.append(item8)
        data.append(item9)
        data.append(item10)
        
        ////////////////////   Styling the User   ///////////////////
        
        
        //////////////   Register the table view cell   ////////////
        self.profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        ////////   Hides the table if no values are found   ///////
        if (items.count)==0{
            profileTableView.isHidden=true;
        }
        profileTableView.estimatedRowHeight = 100.0
        profileTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    func retrieveUserItems() {
        if (UserDefaults.standard.string(forKey: "email")) != nil {
            items = model.fetchItemsForUser(email: UserDefaults.standard.string(forKey: "email")!)
        }
        DispatchQueue.main.async {
            self.profileTableView?.reloadData()
        }
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (items.count)
        
    }
    
    func populateDetails() {
        profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        profileImage.clipsToBounds = true;
        profileImage.layer.borderWidth = 4.5;
        profileImage.layer.borderColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 1).cgColor
        let image = UIImage(data:user.profilephoto! as Data,scale:1.0)
        profileImage.image = image
        
        lblName.text = user.name
        lblLocation.text = "Lives in: " + user.location!
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.profileTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        // set the text from the data model
        cell.textLabel?.text = items[indexPath.row].name
        cell.detailTextLabel?.text = items[indexPath.row].price
        
        return cell
    }
    
    func fetchUserInformation() {
        if (UserDefaults.standard.string(forKey: "email")) != nil {
            user = userModel.fetchUser(email: UserDefaults.standard.string(forKey: "email")!)
        }
    }
    
    @IBAction func addListingButton(_ sender: Any) {
        performSegue(withIdentifier: "addListing", sender: self)
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DetailsDelegate?.sendItem(item: items[indexPath.row])
        print("You tapped cell number \(indexPath.row).")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            DetailsDelegate = destination
        }
    }
}


