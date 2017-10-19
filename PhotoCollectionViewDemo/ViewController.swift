//
//  ViewController.swift
//  PhotoCollectionViewDemo
//
//  Created by Minh Luan Tran on 7/6/17.
//  Copyright © 2017 Minh Luan Tran. All rights reserved.
//

import UIKit
import PhotoCollectionView

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var images : [[UIImage]] = [
        [#imageLiteral(resourceName: "image1")],
        [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2")],
        [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3")],
        [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4")],
        [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4"), #imageLiteral(resourceName: "image5")],
        [#imageLiteral(resourceName: "image1"), #imageLiteral(resourceName: "image2"), #imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image5")],
        [#imageLiteral(resourceName: "dog-1")],
        [#imageLiteral(resourceName: "dog-1"), #imageLiteral(resourceName: "dog-2")],
        [#imageLiteral(resourceName: "dog-1"), #imageLiteral(resourceName: "dog-2"), #imageLiteral(resourceName: "dog-3")],
        [#imageLiteral(resourceName: "dog-1"), #imageLiteral(resourceName: "dog-2"), #imageLiteral(resourceName: "dog-3"), #imageLiteral(resourceName: "dog-4")],
        [#imageLiteral(resourceName: "dog-1"), #imageLiteral(resourceName: "dog-2"), #imageLiteral(resourceName: "dog-3"), #imageLiteral(resourceName: "dog-4"), #imageLiteral(resourceName: "dog-5")],
        [#imageLiteral(resourceName: "dog-1"), #imageLiteral(resourceName: "dog-2"), #imageLiteral(resourceName: "dog-3"), #imageLiteral(resourceName: "dog-4"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5"), #imageLiteral(resourceName: "dog-5")],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = nil
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.images = images[indexPath.row]
        return cell
    }
    
}

