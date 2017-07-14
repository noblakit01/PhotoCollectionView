//
//  ViewController.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var photoCache = PhotoCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PhotoCell
        let urls = [
            "https://www.cesarsway.com/sites/newcesarsway/files/styles/large_article_preview/public/Common-dog-behaviors-explained.jpg",
            "https://d2wq73xazpk036.cloudfront.net/media/27FB7F0C-9885-42A6-9E0C19C35242B5AC/DA746CFE-B4A4-43C0-A02F8BAF7BC6CE20/thul-51a71b71-3799-5e48-8a84-5b08c9efa9cf.jpg",
            "https://cdn.pixabay.com/photo/2016/02/19/15/46/dog-1210559_960_720.jpg",
            "https://www.cesarsway.com/sites/newcesarsway/files/styles/large_article_preview/public/Dog-bite-prevention.jpg",
            "https://static.pexels.com/photos/7720/night-animal-dog-pet.jpg"
        ]
        cell.imageCollectionView.photoCache = photoCache
        cell.url = URL(string: urls[indexPath.row])
        
        return cell
    }
}

class PhotoCell: UITableViewCell, PhotoCollectionViewDataSource {
    var url: URL? {
        didSet {
            imageCollectionView.reloadData()
        }
    }
    @IBOutlet weak var imageCollectionView: PhotoCollectionView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCollectionView.dataSource = self
    }
    
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int {
        return url != nil ? 1 : 0
    }
    
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, urlImageAt index: Int) -> URL? {
        return url
    }
}
