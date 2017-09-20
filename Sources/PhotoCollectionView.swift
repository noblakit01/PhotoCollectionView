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
    
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, imageAt index: Int) -> UIImage?
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, urlImageAt index: Int) -> URL?
}

@objc public protocol PhotoCollectionViewDelegate: NSObjectProtocol {
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didSelectImageAt index: Int)
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didCreated photoView: PhotoView, at index: Int) -> Void
}

@IBDesignable
open class PhotoCollectionView: UIView {
    var photoViews: [PhotoView] = []
    var images: [UIImage?] = []
    var numImage = 0
    
    weak open var dataSource: PhotoCollectionViewDataSource?
    weak open var delegate: PhotoCollectionViewDelegate?
    
    @IBInspectable open var moreTextColor: UIColor! = UIColor.white
    @IBInspectable open var moreTextBackgroundColor: UIColor! = UIColor(white: 0.2, alpha: 0.6)
    open var moreTextFont: UIFont! = UIFont.systemFont(ofSize: 17)
    
    var layout: PhotoLayoutProtocol!
    
    override open var bounds: CGRect {
        didSet {
            reloadData()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        return layout != nil ? layout.contentSize(of: self) : bounds.size
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
    
    func layoutFor(numImage: Int) -> PhotoLayoutProtocol {
        if numImage == 1 {
            return SingleLayout()
        } else if numImage == 2 {
            return DoubleLayout()
        } else if numImage < 11 {
            if numImage % 4 == 0 {
                return EqualSquareLayout()
            } else {
                return OneMainLayout()
            }
        } else {
            return TwoMainLayout()
        }
    }
    
    open func reloadData() {
        clear()
        guard let dataSource = dataSource else {
            return
        }
        numImage = dataSource.numPhotos(in: self)
        guard numImage > 0 else {
            return
        }
        layout = layoutFor(numImage: numImage)
        let numShow = min(layout.maxPhoto, numImage)
        for i in 0..<numShow {
            let image = dataSource.photoCollectionView?(self, imageAt: i)
            images.append(image)
            let frame = layout.frame(at: i, in: self)
            let photoView = PhotoView(frame: frame)
            photoView.tag = i
            
            if let image = image {
                photoView.setImage(image)
            } else if let url = dataSource.photoCollectionView?(self, urlImageAt: i) {
                let absoluteString = url.absoluteString
                photoView.setUrl(url: url) { [weak self] (urlStr, image) in
                    guard let sSelf = self else {
                        return
                    }
                    if absoluteString == urlStr, let image = image {
                        sSelf.images[i] = image
                        sSelf.reloadFrame(at: i)
                    }
                }
            }
            if numImage > layout.maxPhoto && i == numShow - 1 {
                addMoreLabel(in: photoView, numMore: numImage - numShow)
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapPhotoView(sender:)))
            photoView.addGestureRecognizer(tapGesture)
            photoViews.append(photoView)
            addSubview(photoView)
            
            delegate?.photoCollectionView?(self, didCreated: photoView, at: i)
        }
        invalidateIntrinsicContentSize()
    }
    
    func reloadFrame(at index: Int, animated: Bool = true) {
        guard index >= 0 && index < photoViews.count else {
            return
        }
        let photoView = photoViews[index]
        photoView.frame = layout.frame(at: index, in: self)
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


