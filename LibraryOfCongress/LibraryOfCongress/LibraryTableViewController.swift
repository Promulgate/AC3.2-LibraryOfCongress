//
//  LibraryTableViewController.swift
//  LibraryOfCongress
//
//  Created by Eric Chang on 10/30/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
  
  var session: URLSession?
  var task: URLSessionDownloadTask?
  var books = [Book]()
  var endpoint = "https://loc.gov/pictures/search/?q=mark%20twain&fo=json"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    session = URLSession.shared
    task = URLSessionDownloadTask()
    
    APIManager.manager.getData(endPoint: endpoint) { (data: Data?) in
      if let d = data {
        self.books = Book.parseData(with: d)!
      }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  
  // MARK: - Table view data source
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return books.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) as! LibraryTableViewCell
    
    let thisBook = books[indexPath.row]
    var imageURL = thisBook.thumbnail
    imageURL.remove(at: imageURL.startIndex)
    imageURL.remove(at: imageURL.startIndex)

    
    
    
    cell.thumbnailImageView.downloadImage(urlString: imageURL)
    cell.titleLabel.text = thisBook.title
    
    return cell
  }
  
  
  
  // MARK: - Navigation
  // MARK: - Navigation
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let tappedCell = sender as? LibraryTableViewCell {
      if segue.identifier == "BookPickSegue" {
        let selectedBook = segue.destination as! DetailViewController
        let indexPath = self.tableView.indexPath(for: tappedCell)!
        
        selectedBook.thisBook = books[indexPath.row]
      }
    }
    
  }
  
  
}
