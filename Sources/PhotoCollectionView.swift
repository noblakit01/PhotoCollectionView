//
//  PhotoCollectionView.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit
import SwiftyImageCache

public protocol PhotoCollectionViewDataSource: NSObjectProtocol {
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, photoSource index: Int) -> PhotoSource
}

@objc public protocol PhotoCollectionViewDelegate: NSObjectProtocol {
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didSelectImageAt index: Int)
    @objc optional func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didCreated photoView: PhotoView, at index: Int) -> Void
    @objc optional func didChangeSize(of photoCollectionView: PhotoCollectionView)
}

open class PhotoCollectionView: UIView {
    var photoViews: [PhotoView] = []
    var images: [UIImage?] = []
    var urls: [String?] = []
    var numImage = 0
    
    weak open var dataSource: PhotoCollectionViewDataSource?
    weak open var delegate: PhotoCollectionViewDelegate?
    
    open var moreTextColor: UIColor! = UIColor.white
    open var moreTextBackgroundColor: UIColor! = UIColor(white: 0.2, alpha: 0.6)
    open var moreTextFont: UIFont! = UIFont.systemFont(ofSize: 17)
    
    var layout: PhotoLayoutProtocol!
      
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
        urls.removeAll()
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
            let photoSource = dataSource.photoCollectionView(self, photoSource: i)
            var image: UIImage?
            var url: URL?
            switch photoSource {
            case .image(let img):
                image = img
                urls.append(nil)
            case .url(let URL):
                if let imageUrl = URL, let cacheImage = ImageCache.default.image(of: imageUrl) {
                    image = cacheImage
                }
                url = URL
            }
            images.append(image)
            urls.append(url?.absoluteString)
            
            let frame = layout.frame(at: i, in: self)
            let photoView = PhotoView(frame: frame)
            photoView.tag = i
            
            if let image = image {
                photoView.setImage(image)
            } else if let url = url {
                photoView.setUrl(url: url) { [weak self] (urlStr, image) in
                    guard let sSelf = self else {
                        return
                    }
                    guard i >= 0 && i < sSelf.urls.count else {
                        return
                    }
                    if sSelf.urls[i] == urlStr, let image = image {
                        sSelf.images[i] = image
                        if i == 0 {
                            sSelf.reloadFrame()
                        }
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
    
    func reloadFrame() {
        for (index, photoView) in photoViews.enumerated() {
            photoView.frame = layout.frame(at: index, in: self)
        }
        delegate?.didChangeSize?(of: self)
    }
    
    func image(at index: Int) -> UIImage? {
        guard index >= 0 && index < images.count else {
            return nil
        }
        return images[index]
    }
    
    @objc func tapPhotoView(sender: UITapGestureRecognizer) {
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
