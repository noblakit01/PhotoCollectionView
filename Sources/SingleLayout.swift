//
//  SingleLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 8/31/17.
//
//

import UIKit

class SingleLayout: PhotoLayoutProtocol {
    var contentSize: CGSize = CGSize.zero
    
    var maxPhoto: Int {
        return 1
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        guard index >= 0 && index < maxPhoto else {
            return CGRect.zero
        }
        contentSize = photoCollectionView.bounds.size
        guard let image = photoCollectionView.image(at: index) else {
            return CGRect(origin: .zero, size: contentSize)
        }
        let width = photoCollectionView.bounds.width - spacing * 2
        var height = width * image.size.height / image.size.width
        height = min(height, width * 1.1)
        contentSize = CGSize(width: photoCollectionView.bounds.width, height: height + spacing * 2)
        
        return CGRect(origin: CGPoint(x: spacing, y: spacing), size: CGSize(width: width, height: height))
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        return contentSize
    }
    
}
