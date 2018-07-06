import UIKit

private let reuseIdentifier = "Cell"

class MarketplaceCollectionViewController: UICollectionViewController {
    
    var data = [MPItem]()
    var items = [MarketplaceItem]()
    let model = MarketplaceItem()
    var DetailsDelegate: MarketplaceItemDelegate?
    var exampleDesc = "This is a test description to show how the Detail View controller handles text in the scrollable text view. Lorep Ipsum Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveMarketplaceItems()
        
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

        if let layout = collectionView?.collectionViewLayout as? MarketplaceLayout {
            layout.delegate = self
        }
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func retrieveMarketplaceItems() {
        items = model.fetchItems()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    @IBAction func saveItem(_ sender: Any) {
//        let image = UIImage(named: "cat-camp")
//        let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
//        if (model.saveItem(category: 1, condition: 1, description: "test", fragile: true, image: imageData, name: "name", oversized: true, price: "$2.99", size: 1, user: "frostde93@gmail.com", weight: "5.0", location: "Cincinnati, OH", uploaded: "5 h")) {
//            print("it worked")
//            retrieveMarketplaceItems()
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            
            headerView.backgroundColor = UIColor.blue
            return headerView
            
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            
            footerView.backgroundColor = UIColor.green
            return footerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DetailsDelegate?.sendItem(item: items[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            DetailsDelegate = destination
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (items.count)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        
        if let cell = cell as? MarketplaceCollectionViewCell {
            let image = UIImage(data:item.image! as Data,scale:1.0)
            cell.price?.text = item.price
            cell.location?.text = item.location
            cell.thumbNail?.image = image
        }
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

        
        return cell
    }
    
}

extension MarketplaceCollectionViewController: MarketplaceLayoutDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = items[indexPath.item]
        let newImage = UIImage(data:image.image! as Data,scale:1.0)
        let height = newImage?.size.height
        let img: UIImage = newImage!
        let aspectRatio: CGFloat = img.size.width/img.size.height
        let requiredHeight: CGFloat = self.view.bounds.size.width/aspectRatio
        return CGFloat(requiredHeight/2)
    }
    
    
}

