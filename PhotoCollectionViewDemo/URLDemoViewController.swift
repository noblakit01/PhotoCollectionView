//
//  URLDemoViewController.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 9/20/17.
//
//

import UIKit

import PhotoCollectionView

enum UrlDemo: String {
    case cat1 = "https://static.pexels.com/photos/126407/pexels-photo-126407.jpeg"
    case cat2 = "http://www.readersdigest.ca/wp-content/uploads/2011/01/4-ways-cheer-up-depressed-cat.jpg"
    case cat3 = "https://ichef.bbci.co.uk/news/1024/cpsprodpb/693C/production/_95804962_p0517py6.jpg"
    case cat4 = "http://www.petmd.com/sites/default/files/cat-lady-blog.jpg"
    case cat5 = "http://www.lanlinglaurel.com/data/out/109/4898297-cat-picture.jpg"
}

class URLDemoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var urls : [[String]] = [
        [UrlDemo.cat1.rawValue],
        [UrlDemo.cat1.rawValue, UrlDemo.cat2.rawValue],
        [UrlDemo.cat1.rawValue, UrlDemo.cat2.rawValue, UrlDemo.cat3.rawValue],
        [UrlDemo.cat1.rawValue, UrlDemo.cat2.rawValue, UrlDemo.cat3.rawValue, UrlDemo.cat4.rawValue],
        [UrlDemo.cat1.rawValue, UrlDemo.cat2.rawValue, UrlDemo.cat3.rawValue, UrlDemo.cat4.rawValue, UrlDemo.cat5.rawValue],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = nil
    }
    
}

extension URLDemoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! URLTableViewCell
        cell.set(index: indexPath.row)
        cell.photoCollectionView.delegate = self
        cell.urls = urls[indexPath.row]
        return cell
    }
    
}

extension URLDemoViewController: PhotoCollectionViewDelegate {
    
    func didChangeSize(of photoCollectionView: PhotoCollectionView) {
        update(height: photoCollectionView.intrinsicContentSize.height, at: photoCollectionView.tag)
    }
    
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didCreated photoView: PhotoView, at index: Int) {
        update(height: photoCollectionView.intrinsicContentSize.height, at: photoCollectionView.tag)
    }
    
    func update(height: CGFloat, at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        
        if let cell = tableView.cellForRow(at: indexPath) as? URLTableViewCell {
            cell.photoCollectionViewHeight.constant = height
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
}
