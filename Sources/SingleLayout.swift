//
//  SingleLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 8/31/17.
//
//

import UIKit

class SingleLayout: PhotoLayoutProtocol {
    var maxPhoto: Int {
        return 1
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        guard index >= 0 && index < maxPhoto else {
            return CGRect.zero
        }
        
        return CGRect.zero
    }
}
