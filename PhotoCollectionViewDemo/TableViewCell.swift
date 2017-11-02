//
//  TableViewCell.swift
//  PhotoCollectionView
//
//  Created by luan on 9/9/17.
//
//

import UIKit
import PhotoCollectionView

class TableViewCell: UITableViewCell {

    @IBOutlet weak var photoCollectionView: PhotoCollectionView!
    @IBOutlet weak var indexLabel: UILabel!
    
    var images: [UIImage] = [] {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoCollectionView.dataSource = self
    }
    
}

extension TableViewCell: PhotoCollectionViewDataSource {
    
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int {
        return images.count
    }
    
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, imageAt index: Int) -> UIImage? {
        return images[index]
    }
    
}
