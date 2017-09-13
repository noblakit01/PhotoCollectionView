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
    var numMain = 2
    var numSmall = 3
    var isVertical = false
    
    var mainSize = CGSize.zero
    var smallSize = CGSize.zero
    var contentSize = CGSize.zero
    
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        guard index >= 0 && index < maxPhoto else {
            return CGRect.zero
        }
        if index == 0 {
            mainSize = CGSize(width: photoCollectionView.bounds.width - spacing * 2,
                                  height: photoCollectionView.bounds.height - spacing * 2)
            contentSize = photoCollectionView.bounds.size
            isVertical = false
            if let image = photoCollectionView.image(at: index) {
                let ratio = image.size.height / image.size.width
                isVertical = ratio >= 1.0
                if isVertical {
                    mainSize.width = (contentSize.width - spacing * 3) * 0.6
                    mainSize.height = mainSize.width * min(ratio, 1.25)
                    contentSize.height = mainSize.height * 2 + spacing * 3
                    
                    smallSize.width = (contentSize.width - spacing * 3) * 0.4
                    smallSize.height = (contentSize.height - CGFloat(numSmall + 1) * spacing) / CGFloat(numSmall)
                } else {
                    mainSize.height = mainSize.width * min(ratio, 0.8)
                    contentSize.height = mainSize.height * 1.0 / 0.6 + spacing * 3
                    
                    smallSize.width = (contentSize.width - CGFloat(numSmall + 1) * spacing) / CGFloat(numSmall)
                    smallSize.height = mainSize.height * 0.4 / 0.6
                }
            }
        }
        
        let origin: CGPoint
        let size: CGSize
        if index < numMain {
            origin = {
                if isVertical {
                    return CGPoint(x: spacing,
                                   y: spacing + (mainSize.height + spacing) * CGFloat(index))
                } else {
                    return CGPoint(x: spacing + (mainSize.width + spacing) * CGFloat(index),
                                   y: spacing)
                }
            }()
            size = mainSize
        } else {
            let smallIndex = CGFloat(index - numMain)
            origin = {
                if isVertical {
                    return CGPoint(x: spacing * 2 + mainSize.width,
                                   y: spacing + (smallSize.height + spacing) * smallIndex)
                } else {
                    return CGPoint(x: spacing + (smallSize.width + spacing) * smallIndex,
                                   y: spacing * 2 + mainSize.height)
                }
            }()
            size = smallSize
        }
        
        return CGRect(origin: origin, size: size)
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        return contentSize
    }
    
}
