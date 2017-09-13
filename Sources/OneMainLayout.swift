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
    var mainItemSize: CGSize = .zero
    var smallItemSize: CGSize = .zero
    var contentSize: CGSize = .zero
    
    var maxPhoto: Int {
        return 4
    }
    var mainWidthPercent: CGFloat {
        return 0.6
    }
    
    var mainHeightPercent: CGFloat {
        return 0.6
    }
    
    var smallWidthPercent: CGFloat {
        return 1.0 - mainWidthPercent
    }
    
    var smallHeightPercent: CGFloat {
        return 1.0 - mainHeightPercent
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        let numPhoto = min(maxPhoto, photoCollectionView.numImage)
        guard index >= 0 && index < numPhoto else {
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
                    mainItemSize.width = (photoCollectionView.bounds.width - spacing * 3) * mainWidthPercent
                    mainItemSize.height = mainItemSize.width * min(ratio, 1.25)
                    contentSize.height = mainItemSize.height + spacing * 2
                    
                    smallItemSize.width = (photoCollectionView.bounds.width - spacing * 3) * smallWidthPercent
                    smallItemSize.height = (mainItemSize.height - CGFloat(numPhoto - 2) * spacing) / CGFloat(numPhoto - 1)
                } else {
                    mainItemSize.height = mainItemSize.width * min(ratio, 0.8)
                    contentSize.height = mainItemSize.height * 1.0 / mainWidthPercent + spacing * 3
                    
                    smallItemSize.width = (mainItemSize.width - CGFloat(numPhoto - 2) * spacing) / CGFloat(numPhoto - 1)
                    smallItemSize.height = mainItemSize.height * smallHeightPercent / mainHeightPercent
                }
            }
            return CGRect(origin: CGPoint(x: spacing, y: spacing), size: mainItemSize)
        }
        let smallIndex = CGFloat(index) - 1
        let x = isVertical ? mainItemSize.width + spacing * 2 : spacing + (smallItemSize.width + spacing) * smallIndex
        let y = isVertical ? spacing + (smallItemSize.height + spacing) * smallIndex : mainItemSize.height + spacing * 2
        
        return CGRect(origin: CGPoint(x: x, y: y), size: smallItemSize)
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        return contentSize
    }
}
