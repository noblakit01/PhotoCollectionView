//
//  OneMainLayout.swift
//  PhotoCollectionView
//
//  Created by luan on 9/4/17.
//
//

import UIKit

class OneMainLayout: PhotoLayoutProtocol {
    var maxPhoto: Int {
        return 4
    }
    
    func frame(at index: Int, in photoCollectionView: PhotoCollectionView) -> CGRect {
        return photoCollectionView.bounds
    }
}
