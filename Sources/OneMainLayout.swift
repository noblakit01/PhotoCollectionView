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
                                  height: photoCollectionView.bounds.height)
            if let image = photoCollectionView.image(at: index) {
                let ratio = image.size.height / image.size.width
                isVertical = ratio >= 1.0
                if isVertical {
                    mainSize.width = (photoCollectionView.bounds.width - spacing * 3) / 2
                    mainSize.height = mainSize.width * min(ratio, 1.25)
                } else {
                    mainSize.height = width * min(ratio, 0.8)
                }
            }
        }
        return photoCollectionView.bounds
    }
}
