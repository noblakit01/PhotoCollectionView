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
    
    var queue = DispatchQueue(label: "PhotoCache")
    var workItems = NSCache<NSString, DispatchWorkItem>()
    var images = NSCache<NSString, UIImage>()
    
    func loadImage(atUrl url: URL, completion: @escaping (UIImage?) -> Void) {
        let urlString = url.absoluteString
        if let image = images.object(forKey: urlString as NSString) {
            completion(image)
            return
        }
        if let workItem = workItems.object(forKey: urlString as NSString) {
            workItem.notify(queue: queue, execute: {
                if let image = self.images.object(forKey: urlString as NSString) {
                    completion(image)
                }
            })
            return
        }
        let workItem = DispatchWorkItem {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    self.images.setObject(image, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch ( _) {
                completion(nil)
            }
        }
        workItems.setObject(workItem, forKey: urlString as NSString)
        queue.async(execute: workItem)
    }
}
