//
//  PhotoCollectionViewCell.swift
//  iKidz
//
//  Created by luan on 7/7/17.
//  Copyright © 2017 Sua Le. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    lazy var moreLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.4)
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        addSubview(moreLabel)
        leftAnchor.constraint(equalTo: moreLabel.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: moreLabel.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: moreLabel.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: moreLabel.bottomAnchor).isActive = true
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
