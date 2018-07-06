//
//  SecondViewController.swift
//  Bundle
//
//  Created by Tyler Manning on 4/5/18.
//  Copyright © 2018 Bundle. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var itemImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = itemImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

