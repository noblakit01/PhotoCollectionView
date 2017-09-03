//
//  DoubleLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 9/2/17.
//
//

import UIKit

class DoubleLayout: PhotoLayoutProtocol {
    var contentSize: CGSize = CGSize.zero
    var itemSize: CGSize = CGSize.zero
    
    var maxPhoto: Int {
        return 2
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        guard index >= 0 && index < maxPhoto else {
            return CGRect.zero
        }
        
        contentSize = photoCollectionView.bounds.size
        guard let image = photoCollectionView.image(at: index) else {
            return CGRect(origin: .zero, size: contentSize)
        }
        let width = (photoCollectionView.bounds.width - spacing * CGFloat(maxPhoto + 1)) / CGFloat(maxPhoto)
        var height = width * image.size.height / image.size.width
        height = min(height, width * 1.25)
        itemSize = CGSize(width: width, height: height)
        contentSize = CGSize(width: photoCollectionView.bounds.width, height: height)
        return CGRect(origin: .zero, size: contentSize)
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        return contentSize
    }

}
