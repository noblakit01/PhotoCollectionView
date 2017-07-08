//
//  PhotoCollectionViewCell.swift
//  iKidz
//
//  Created by luan on 7/7/17.
//  Copyright © 2017 Sua Le. All rights reserved.
//

import UIKit

class PhotoView: UIView {
    
    lazy var imageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        if #available(iOS 9.0, *) {
            leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        } else {
            let constraints = [
                NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0),
            ]
            addConstraints(constraints)
        }
        
        backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
