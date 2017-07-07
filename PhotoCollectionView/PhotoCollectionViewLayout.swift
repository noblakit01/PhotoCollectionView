//
//  PhotoCollectionViewLayout.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit

class PhotoCollectionViewLayout: UICollectionViewLayout {
    
    var cacheAttributes = [UICollectionViewLayoutAttributes]()
    var offset = CGPoint.zero
    var didLoad = false
    
    var marginVer: CGFloat = 1
    var marginHor: CGFloat = 1
    
    override func prepare() {
        super.prepare()
        
        if didLoad {
            return
        }
        let size = collectionView!.frame.size
        
        for section in 0..<collectionView!.numberOfSections {
            let count = collectionView!.numberOfItems(inSection: section)
            let isVertical = true
            for item in 0..<count {
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                var width: CGFloat = 0
                var height: CGFloat = 0
                
                if count == 1 {
                    width = size.width
                    height = size.height
                } else if count < 5 {
                    let remainCount = CGFloat(count - 1)
                    if isVertical {
                        width = (size.width - marginHor) / 2
                        height = item == 0 ? size.height : (size.height - marginVer * (remainCount - 1)) / remainCount
                    } else {
                        width = item == 0 ? size.width : (size.width - marginHor * (remainCount - 1)) / remainCount
                        height = (size.height - marginVer) / 2
                    }
                }
                attribute.frame = CGRect(origin: offset, size: CGSize(width: width, height: height))
                offset.x += width + 1
                offset.y += height + 1
                
                cacheAttributes.append(attribute)
            }
        }
        didLoad = true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cacheAttributes {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
