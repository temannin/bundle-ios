import UIKit
import Foundation

protocol MarketplaceItemDelegate {
    func sendItem(item: MarketplaceItem)
}

class DetailViewController: UIViewController, MarketplaceItemDelegate {
   // let model = MarketplaceItem()
    //var model: MarketplaceItem!
    var MarketplaceItem: MarketplaceItem!
    let userModel = User()
    var user = User()
    var seller = User()
    var conditionArray = ["New", "Like New", "Good", "OK"]
    var categoryArray = ["Appliances", "Electronics", "Clothing", "Furniture", "Accessories", "Household", "Automobiles", "Miscellaneous"]
    var sizeArray = ["Small", "Medium", "Large", "Oversized"]

    //outlets
    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var detailsBackground: UIView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var buyButton2: UIButton!
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        buyItem()
    }
    @IBAction func buyButton2Pressed(_ sender: UIButton) {
        buyItem()
    }
    
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var fragile: UIImageView!
    @IBOutlet weak var largeItem: UIImageView!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var sellerBio: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserInformation()
       // model = MarketplaceItem()
        
        //corner radius
        detailsBackground.layer.cornerRadius = 15.0
        
        // shadow
        detailsBackground.layer.shadowColor = UIColor.black.cgColor
        detailsBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        detailsBackground.layer.shadowOpacity = 0.33
        detailsBackground.layer.shadowRadius = 3.0
        
        // Button Shadow and Radius
        buyButton.layer.masksToBounds = false
        buyButton.layer.cornerRadius = 5.0
        buyButton2.layer.masksToBounds = false
        buyButton2.layer.cornerRadius = 5.0
        
        //currentDate
        // get the current date and time
        let currentDateTime = Date()
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        // "Month Day, Year"
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let uploadDate = formatter.string(from: currentDateTime)
        
        //marketplace item link
        itemName.text = MarketplaceItem.name
        price.text = MarketplaceItem.price
        duration.text = uploadDate
        location.text = MarketplaceItem.location
        let image = UIImage(data:MarketplaceItem.image! as Data,scale:1.0)
        thumbNail.image = image
        productDescription.text = MarketplaceItem.desc
        condition.text = conditionArray[Int(MarketplaceItem.condition)]

        weight.text = String(describing:MarketplaceItem.weight)
        size.text = MarketplaceItem.size

        if MarketplaceItem.fragile == true {
            fragile.image = UIImage(imageLiteralResourceName: "checked")
        } else {
            fragile.image = UIImage(imageLiteralResourceName: "cancel")
        }
        if MarketplaceItem.oversized == true {
            largeItem.image = UIImage(imageLiteralResourceName: "checked")
        } else {
            largeItem.image = UIImage(imageLiteralResourceName: "cancel")
        }
        
        //seller info link
        
        //sellerName.text = User.
        seller = user.fetchUser(email: MarketplaceItem.user!)
        sellerName.text = seller.name
        let userImage = UIImage(data:seller.profilephoto! as Data,scale:1.0)
        sellerImage.image = userImage
        
        
        ////////////////////   Styling the User   ///////////////////
        sellerImage.layer.cornerRadius = sellerImage.frame.size.width / 2;
        sellerImage.clipsToBounds = true;
        sellerImage.layer.borderWidth = 4.5;
        sellerImage.layer.borderColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 1).cgColor

    }

    func fetchUserInformation() {
        if (UserDefaults.standard.string(forKey: "email")) != nil {
            user = userModel.fetchUser(email: UserDefaults.standard.string(forKey: "email")!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sendItem(item: MarketplaceItem) {
        MarketplaceItem = item
    }
    
    func buyItem () {
        if MarketplaceItem.purchased == false {
            let alert = UIAlertController(title: MarketplaceItem.name, message: "Are you sure you want to buy this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Buy", comment: "Default action"), style: .`default`, handler: { _ in
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel Action"), style: .`cancel`, handler: { _ in
            }))
            MarketplaceItem.setAsPurchased(item: MarketplaceItem)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: MarketplaceItem.name, message: "Sorry this item has already been puchased.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Darn..", comment: "Cancel Action"), style: .`default`, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    



}
