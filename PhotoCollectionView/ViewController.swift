//
//  ViewController.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: PhotoCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.count = 5
        imageCollectionView.images = [
            UIImage(named: "dog-1")!,
            UIImage(named: "dog-2")!,
            UIImage(named: "dog-3")!,
            UIImage(named: "dog-4")!,
            //UIImage(named: "dog-5")!
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

