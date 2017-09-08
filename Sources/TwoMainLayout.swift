//
//  TwoMainLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 9/7/17.
//
//

import Foundation
import UIKit

class TwoMainLayout: PhotoLayoutProtocol {
    var maxPhoto: Int {
        return 5
    }
    var numMainPhoto = 2
    var isVertical = false
    var mainItemSize = CGSize.zero
    var smallItemSize = CGSize.zero
    var contentSize = CGSize.zero
    
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        guard index >= 0 && index < maxPhoto else {
            return CGRect.zero
        }
        if index == 0 {
            mainItemSize = CGSize(width: photoCollectionView.bounds.width - spacing * 2,
                                  height: photoCollectionView.bounds.height - spacing * 2)
            contentSize = photoCollectionView.bounds.size
            isVertical = false
            if let image = photoCollectionView.image(at: index) {
                let ratio = image.size.height / image.size.width
                isVertical = ratio >= 1.0
                if isVertical {
                    mainItemSize.width = (photoCollectionView.bounds.width - spacing * 3) * 0.6
                    mainItemSize.height = mainItemSize.width * min(ratio, 1.25)
                    contentSize.height = mainItemSize.height * 2 + spacing * 3
                    
                    smallItemSize.width = (photoCollectionView.bounds.width - spacing * 3) * 0.4
                    smallItemSize.height = (mainItemSize.height - CGFloat(maxPhoto - 2) * spacing) / CGFloat(maxPhoto - 1)
                } else {
                    mainItemSize.height = mainItemSize.width * min(ratio, 0.8)
                    contentSize.height = mainItemSize.height * 1.0 / 0.6 + spacing * 3
                    
                    smallItemSize.width = (mainItemSize.width - CGFloat(maxPhoto - 2) * spacing) / CGFloat(maxPhoto - 1)
                    smallItemSize.height = mainItemSize.height * 0.4 / 0.6
                }
            }
            return CGRect(origin: CGPoint(x: spacing, y: spacing), size: mainItemSize)
        }
        let smallIndex = CGFloat(index) - 1
        let x = isVertical ? mainItemSize.width + spacing * 2 : spacing + (smallItemSize.width + spacing) * smallIndex
        let y = isVertical ? spacing + (smallItemSize.height + spacing) * smallIndex : mainItemSize.height + spacing * 2
        
        return CGRect(origin: CGPoint(x: x, y: y), size: mainItemSize)
    }
    
    
    
}
