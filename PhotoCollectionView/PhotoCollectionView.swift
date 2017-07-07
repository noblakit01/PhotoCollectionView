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
        return min(images.count, maxImage)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
}

