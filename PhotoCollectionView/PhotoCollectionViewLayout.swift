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
    var nextOffset = CGPoint.zero
    var didLoad = false
    
    var marginVer: CGFloat = 1
    var marginHor: CGFloat = 1
    
    override func prepare() {
        super.prepare()
        
        if didLoad {
            return
        }
        guard let collectionView = collectionView as? PhotoCollectionView else {
            return
        }
        
        let count = min(collectionView.images.count, collectionView.numberOfItems(inSection: 0))
        guard count > 0 else {
            return
        }
        cacheAttributes.removeAll()
        
        let size = collectionView.frame.size
        let firstImageSize = collectionView.images.first!.size
        let isVertical = firstImageSize.width < firstImageSize.height
        for item in 0..<count {
            let indexPath = IndexPath(item: item, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            var itemSize = CGSize.zero
            let offset = nextOffset
            
            if count == 1 {
                itemSize.width = size.width
                itemSize.height = size.height
            } else {
                let remainCount = CGFloat(count - 1)
                if isVertical {
                    itemSize.width = (size.width - marginHor) / 2
                    if item == 0 {
                        itemSize.height = size.height
                        nextOffset.x += itemSize.width + marginHor
                    } else {
                        itemSize.height = (size.height - marginVer * (remainCount - 1)) / remainCount
                        nextOffset.y += itemSize.height + marginVer
                    }
                } else {
                    itemSize.height = (size.height - marginVer) / 2
                    if item == 0 {
                        itemSize.width = size.width
                        nextOffset.y += itemSize.height + marginVer
                    } else {
                        itemSize.width = (size.width - marginHor * (remainCount - 1)) / remainCount
                        nextOffset.x += itemSize.width + marginHor
                    }
                }
            }
            attribute.frame = CGRect(origin: offset, size: itemSize)
            cacheAttributes.append(attribute)
        }
        didLoad = true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes
    }
}
