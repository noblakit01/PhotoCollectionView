//
//  PhotoCollectionView.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit

@objc public protocol PhotoCollectionViewDataSource: NSObjectProtocol {
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int
    
    @objc optional func photoColletionView(_ photoCollectionView: PhotoCollectionView, imageAt index: Int) -> UIImage?
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, urlImageAt index: Int) -> URL?
}

@objc public protocol PhotoCollectionViewDelegate: NSObjectProtocol {
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didSelectImageAt index: Int)
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didCreated photoView: PhotoView, at index: Int) -> Void
}

@IBDesignable
open class PhotoCollectionView: UIView {
    var margin: CGFloat = 1
    var maxImage = 4
    var photoViews: [PhotoView] = []
    var images: [UIImage?] = []
    
    weak open var dataSource: PhotoCollectionViewDataSource?
    weak open var delegate: PhotoCollectionViewDelegate?
    
    @IBInspectable open var moreTextColor: UIColor! = UIColor.white
    @IBInspectable open var moreTextBackgroundColor: UIColor! = UIColor(white: 0.2, alpha: 0.6)
    open var moreTextFont: UIFont! = UIFont.systemFont(ofSize: 17)
    
    override open var bounds: CGRect {
        didSet {
            reloadData()
        }
    }
    
    override open func removeFromSuperview() {
        super.removeFromSuperview()
        clear()
    }
    
    func clear() {
        while photoViews.count > 0 {
            let view = photoViews.removeFirst()
            view.removeFromSuperview()
        }
        images.removeAll()
    }
    
    open func reloadData() {
        clear()
        guard let dataSource = dataSource else {
            return
        }
        let numImage = dataSource.numPhotos(in: self)
        guard numImage > 0 else {
            return
        }
        
        let numShow = min(maxImage, numImage)
        
        let size = bounds.size
        var isVertical = false
        var nextOffset = CGPoint.zero
        
        for i in 0..<numShow {
            let image = dataSource.photoColletionView?(self, imageAt: i)
            images.append(image)
            if let image = image {
                if i == 0 {
                    isVertical = image.size.width < image.size.height
                }
            }
            var itemSize = CGSize.zero
            let offset = nextOffset
            
            if numShow == 1 {
                itemSize.width = size.width
                itemSize.height = size.height
            } else {
                let remainCount = CGFloat(numShow - 1)
                if isVertical {
                    if i == 0 {
                        itemSize = CGSize(width: (size.width - margin) * 0.6, height: size.height)
                        nextOffset.x += itemSize.width + margin
                    } else {
                        itemSize = CGSize(width: (size.width - margin) * 0.4, height: size.height)
                        itemSize.height = (size.height - margin * (remainCount - 1)) / remainCount
                        nextOffset.y += itemSize.height + margin
                    }
                } else {
                    if i == 0 {
                        itemSize = CGSize(width: size.width, height: (size.height - margin) * 0.6)
                        itemSize.width = size.width
                        nextOffset.y += itemSize.height + margin
                    } else {
                        itemSize = CGSize(width: size.width, height: (size.height - margin) * 0.4)
                        itemSize.width = (size.width - margin * (remainCount - 1)) / remainCount
                        nextOffset.x += itemSize.width + margin
                    }
                }
            }

            let photoView = PhotoView(frame: CGRect(origin: offset, size: itemSize))
            photoView.tag = i
            if let image = image {
                photoView.setImage(image)
            } else if let url = dataSource.photoCollectionView?(self, urlImageAt: i) {
                photoView.setUrl(url: url)
            }
            if numImage > maxImage && i == numShow - 1 {
                addMoreLabel(in: photoView, numMore: numImage - numShow)
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapPhotoView(sender:)))
            photoView.addGestureRecognizer(tapGesture)
            photoViews.append(photoView)
            addSubview(photoView)
            
            delegate?.photoCollectionView?(self, didCreated: photoView, at: i)
        }
    }
    
    func image(at index: Int) -> UIImage? {
        guard index >= 0 && index < images.count else {
            return nil
        }
        return images[index]
    }
    
    func tapPhotoView(sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            delegate?.photoCollectionView?(self, didSelectImageAt: tag)
        }
    }
    
    fileprivate func addMoreLabel(in photoView: PhotoView, numMore: Int) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = moreTextBackgroundColor
        label.textColor = moreTextColor
        label.font = moreTextFont
        label.textAlignment = .center
        label.text = "+\(numMore)"
        
        photoView.addSubview(label)
        let constraints = [
            NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: photoView, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: photoView, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: photoView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: photoView, attribute: .bottom, multiplier: 1.0, constant: 0),
            ]
        photoView.addConstraints(constraints)
    }
}


