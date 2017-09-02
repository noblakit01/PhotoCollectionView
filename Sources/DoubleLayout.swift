//
//  DoubleLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 9/2/17.
//
//

import UIKit

class DoubleLayout: PhotoLayoutProtocol {
    var maxPhoto: Int {
        return 2
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        return CGRect.zero
    }
    
    func contentSize(of photoCollectionView: PhotoCollectionView) -> CGSize {
        return CGSize.zero
    }

}
