//
//  ItemDetailsViewController.swift
//  Bundle
//
//  Created by Beverly Rorer on 4/16/18.
//  Copyright © 2018 Bundle. All rights reserved.
//

import UIKit


class ItemDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    //itemImage
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var itemPrice: UITextField!
    
    @IBOutlet weak var itemCondition: UITextField!
    
    var condition = ["New", "Like New", "Good"]
    
    var conPicker = UIPickerView()
    
    @IBOutlet weak var homeAddress: UITextField!
    
    @IBOutlet weak var itemCategory: UITextField!
    
    var category = ["Appliances", "Electronics", "Miscellaneous"]
    
    var catPicker = UIPickerView()
    
    @IBOutlet var fragile: UILabel!
    
    @IBOutlet weak var itemWeight: UITextField!
    
    var size = ["Small", "Medium", "Large"]
    
    var sizePicker = UIPickerView()
    
    @IBOutlet weak var itemSize: UITextField!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet var itemDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conPicker.delegate = self
        conPicker.dataSource = self
        itemCondition.inputView = conPicker
        
        catPicker.delegate = self
        catPicker.dataSource = self
        itemCategory.inputView = catPicker
        
        sizePicker.delegate = self
        sizePicker.dataSource = self
        itemSize.inputView = sizePicker
        
        itemVisible()
        
        itemImage.image = UIImage(named: "Manley+Sofa")
        self.itemImage.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        print("Yes")
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        print("No")
    }
    func itemVisible(){
        if itemSize.text == "Large" {
            yesButton.isHidden = false
            noButton.isHidden = false
            fragile.isHidden = false
            
        }
        else{
            yesButton.isHidden = true
            noButton.isHidden = true
            fragile.isHidden = true
            
            
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == conPicker{
            return condition.count
        }
        else if pickerView == catPicker{
            return category.count
        }
        else{
            return size.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == conPicker{
            itemCondition.text = condition[row]
            itemCondition.resignFirstResponder()
        }
        else if pickerView == catPicker{
            itemCategory.text = category[row]
            itemCategory.resignFirstResponder()
        }
        else{
            itemSize.text = size[row]
            itemSize.resignFirstResponder()
        }
        itemVisible()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == conPicker{
            return condition[row]
        }
        else if pickerView == catPicker{
            return category[row]
        }
        else{
            return size[row]
        }
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Adding Listing", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.showDetailViewController(alert, sender: true)
        
        //let listing = Listing()
        //listing.image = itemImage.image
        //listing.name = itemName.text
        //listing.price = itemPrice.text
        //listing.condition = itemCondition.text
        //listing.address = homeAddress.text
        //listing.category = itemCategory.text
        //listing.weight = itemWeight.text
        //listing.size = itemSize.text
        //listing.description = itemDescription.text
        //listing.fragile = yesButton.text
        //listing.notFragile = noButton.text
        
        //        try! realm.write {
        //            realm.add(book)
        //        }
        
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemName.resignFirstResponder()
        itemPrice.resignFirstResponder()
        homeAddress.resignFirstResponder()
        itemWeight.resignFirstResponder()
        return true
    }
    
    
}

