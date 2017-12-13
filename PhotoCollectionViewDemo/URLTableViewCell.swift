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
    
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int {
        return urls.count
    }
    
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, urlImageAt index: Int) -> URL? {
        return URL(string: urls[index])
    }
    
}
