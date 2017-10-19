//
//  PhotoLayoutProtocol.swift
//  PhotoCollectionView
//
//  Created by luan on 8/29/17.
//
//

import Foundation
import UIKit

protocol PhotoLayoutProtocol {
    var maxPhoto: Int {get}
    var spacing: CGFloat {get}
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize
}

extension PhotoLayoutProtocol {
    var spacing: CGFloat {
        return 2
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        return photoCollectionView.bounds.size
    }
    
}
