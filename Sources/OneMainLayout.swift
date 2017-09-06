//
//  OneMainLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 9/4/17.
//
//

import UIKit

class OneMainLayout: PhotoLayoutProtocol {
    var isVertical = false
    var smallItemSize: CGSize = .zero
    var contentSize: CGSize = .zero
    
    var maxPhoto: Int {
        return 4
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        let numPhoto = min(maxPhoto, photoCollectionView.numImage)
        guard index >= 0 && index < numPhoto else {
            return CGRect.zero
        }
        if index == 0 {
            var mainSize = CGSize(width: photoCollectionView.bounds.width - spacing * 2,
                                  height: photoCollectionView.bounds.height - spacing * 2)
            contentSize = photoCollectionView.bounds.size
            isVertical = false
            if let image = photoCollectionView.image(at: index) {
                let ratio = image.size.height / image.size.width
                isVertical = ratio >= 1.0
                if isVertical {
                    mainSize.width = (photoCollectionView.bounds.width - spacing * 3) * 0.6
                    mainSize.height = mainSize.width * min(ratio, 1.25)
                    contentSize.height = mainSize.height + spacing * 2
                    
                    smallItemSize.width = (photoCollectionView.bounds.width - spacing * 3) * 0.4
                    smallItemSize.height = (mainSize.height - CGFloat(numPhoto - 2) * spacing) / CGFloat(numPhoto - 1)
                } else {
                    mainSize.height = mainSize.width * min(ratio, 0.8)
                    contentSize.height = mainSize.height * 1.0 / 0.6 + spacing * 3
                    
                    smallItemSize.width = (mainSize.width - CGFloat(numPhoto - 2) * spacing) / CGFloat(numPhoto - 1)
                    smallItemSize.height = mainSize.height * 0.4 / 0.6
                }
            }
            return CGRect(origin: CGPoint(x: spacing, y: spacing), size: mainSize)
        }
        return photoCollectionView.bounds
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        return contentSize
    }
}
