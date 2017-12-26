//
//  URLTableViewCell.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 9/20/17.
//
//

import UIKit
import PhotoCollectionView

class URLTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoCollectionView: PhotoCollectionView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var photoCollectionViewHeight: NSLayoutConstraint!
    
    var urls: [String] = [] {
        didSet {
            if urls != oldValue {
                photoCollectionView.reloadData()
            }
            photoCollectionViewHeight.constant = photoCollectionView.intrinsicContentSize.height
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoCollectionView.dataSource = self
    }
    
    func set(index: Int) {
        photoCollectionView.tag = index
        indexLabel.text = "Cell \(index)"
    }

}

extension URLTableViewCell: PhotoCollectionViewDataSource {
    
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, photoSource index: Int) -> PhotoSource {
        return .url(URL(string: urls[index]))
    }
    
    
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int {
        return urls.count
    }
    
}
