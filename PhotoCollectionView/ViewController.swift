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
        imageCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: PhotoCollectionViewDataSource {
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int {
        return 5
    }
    
    func photoColletionView(_ photoCollectionView: PhotoCollectionView, imageAt index: Int) -> UIImage {
        return UIImage(named: "dog-\(index + 1)")!
    }
}
