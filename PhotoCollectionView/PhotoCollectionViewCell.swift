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
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        contentView.addSubview(moreLabel)
        contentView.leftAnchor.constraint(equalTo: moreLabel.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: moreLabel.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: moreLabel.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: moreLabel.bottomAnchor).isActive = true
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
