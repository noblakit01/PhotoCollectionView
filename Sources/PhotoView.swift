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
    lazy var loadingView: UIActivityIndicatorView! = {
        let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        loadingView.hidesWhenStopped = true
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(loadingView)
        let constraints = [
            NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: loadingView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
            ]
        self.addConstraints(constraints)
        return loadingView
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func setUrl(url: URL, photoCache: PhotoCache) {
        loadingView.startAnimating()
        photoCache.loadImage(atUrl: url, completion: { [weak self] image in
            guard let sSelf = self else {
                return
            }
            sSelf.imageView.image = image
            sSelf.loadingView.stopAnimating()
        })
    }
}
