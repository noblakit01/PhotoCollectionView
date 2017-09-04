//
//  DoubleLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 9/2/17.
//
//

import UIKit

class DoubleLayout: PhotoLayoutProtocol {
    var itemSize: CGSize = CGSize.zero
    var isVertical = false
    
    var maxPhoto: Int {
        return 2
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        guard index >= 0 && index < maxPhoto else {
            return CGRect.zero
        }
        if index == 0 {
            if let image = photoCollectionView.image(at: index) {
                let ratio = image.size.height / image.size.width
                isVertical = ratio > 1.0
                if isVertical {
                    let width = (photoCollectionView.bounds.width - spacing * 3) / 2
                    itemSize = CGSize(width: width, height: width * min(ratio, 1.25))
                } else {
                    let width = photoCollectionView.bounds.width - spacing * 2
                    itemSize = CGSize(width: width, height: width * min(ratio, 0.8))
                }
            } else {
                isVertical = false
                itemSize = CGSize(width: photoCollectionView.bounds.width - spacing * 2,
                                  height: photoCollectionView.bounds.height - spacing * 3)
            }
        }
        
        let x = spacing + (spacing + itemSize.width) * CGFloat(isVertical ? index : 0)
        let y = spacing + (spacing + itemSize.height) * CGFloat(isVertical ? 0 : index)
        return CGRect(origin: CGPoint(x: x, y: y), size: itemSize)
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        if isVertical {
            return CGSize(width: itemSize.width * 2 + spacing * 3, height: itemSize.height + spacing * 2)
        } else {
            return CGSize(width: itemSize.width + spacing * 2, height: itemSize.height * 2 + spacing * 3)
        }
    }

}
