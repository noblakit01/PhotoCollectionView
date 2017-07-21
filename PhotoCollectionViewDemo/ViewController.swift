//
//  ViewController.swift
//  PhotoCollectionViewDemo
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit
import PhotoCollectionView

class ViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: PhotoCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: PhotoCollectionViewDataSource {
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int {
        return 10
    }
    
    func photoColletionView(_ photoCollectionView: PhotoCollectionView, imageAt index: Int) -> UIImage? {
        return UIImage(named: "image\(index + 1)")
    }
}

extension ViewController: PhotoCollectionViewDelegate {
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didSelectImageAt index: Int) {
        print("Press at index \(index)")
    }
}
