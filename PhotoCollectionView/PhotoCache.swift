//
//  PhotoCache.swift
//  PhotoCollectionDemo
//
//  Created by Minh Luan Tran on 7/13/17.
//  Copyright © 2017 luantran. All rights reserved.
//

import UIKit

class PhotoCache {
    
    static let `default` = PhotoCache()
    
    var limitMemory: Int = 100 // (Mb)
    var queue = DispatchQueue(label: "PhotoCache")
    
    func loadImage(atUrl url: URL, completion: @escaping (UIImage?) -> Void) {
        queue.async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } catch ( _) {
                completion(nil)
            }
        }
    }
}
