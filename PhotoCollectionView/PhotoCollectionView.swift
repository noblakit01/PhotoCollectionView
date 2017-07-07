//
//  PhotoCollectionView.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit

class PhotoCollectionView: UICollectionView {
    
    fileprivate var photoLayout = PhotoCollectionViewLayout()
    fileprivate let photoCellIdentifier = "PhotoCell"
    fileprivate var numItems = 0
    
    var count: Int = 0
    var images = [UIImage]()
    var maxImage = 4
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLayout()
    }
    
    fileprivate func initLayout() {
        backgroundColor = UIColor.white
        dataSource = self
        collectionViewLayout = photoLayout
        register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: photoCellIdentifier)
    }
    
    override func reloadData() {
        super.reloadData()
        photoLayout.didLoad = false
    }
}

extension PhotoCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numItems = min(count, maxImage)
        return numItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        if count > maxImage && indexPath.item == numItems - 1 {
            cell.moreLabel.isHidden = false
            cell.moreLabel.text = "+\(count - numItems)"
        }
        return cell
    }
}

