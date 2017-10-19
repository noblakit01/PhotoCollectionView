//
//  EqualSquareLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 8/30/17.
//
//

import UIKit

class EqualSquareLayout: PhotoLayoutProtocol {
    var maxPhoto: Int {
        return 4
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        guard index >= 0 && index < maxPhoto else {
            return CGRect.zero
        }
        let bounds = photoCollectionView.bounds
        let width = (bounds.width - spacing * 3) / 2
        let x = index % 2
        let y = index / 2
        
        let origin = CGPoint(x: spacing + CGFloat(x) * (width + spacing), y: spacing + CGFloat(y) * (width + spacing))
        let size = CGSize(width: width, height: width)
        
        return CGRect(origin: origin, size: size)
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        let bounds = photoCollectionView.bounds
        return CGSize(width: bounds.width, height: bounds.width)
    }
    
}
