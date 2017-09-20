//
//  URLDemoViewController.swift
//  PhotoCollectionView
//
//  Created by Minh Luan Tran on 9/20/17.
//
//

import UIKit

import PhotoCollectionView

class URLDemoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var images : [[String]] = [
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = nil
    }
}

extension URLDemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! URLTableViewCell
        return cell
    }
}
