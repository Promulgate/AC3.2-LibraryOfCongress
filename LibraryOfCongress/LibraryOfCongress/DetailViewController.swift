//
//  DetailViewController.swift
//  LibraryOfCongress
//
//  Created by Eric Chang on 10/30/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var squareImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subjectTextView: UITextView!
  
  var thisBook: Book?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
  }
  
  
  func loadData() {
    titleLabel.text = thisBook?.title
    
    var imageURL = (thisBook?.fullImage)!
    imageURL.remove(at: imageURL.startIndex)
    imageURL.remove(at: imageURL.startIndex)
    loadImage(url: URL(string: imageURL)!)
    
    var list = ""
    for i in (thisBook?.subjectList)! {
      list.append("\(i)\n")
    }
    subjectTextView.text = list
  }
  
  
  func loadImage(url: URL) {
    let shareSession = URLSession.shared
    let downloadTask = shareSession.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
      if location != nil {
        DispatchQueue.main.async {
          let data:Data! = try? Data(contentsOf: location!)
          let image = UIImage(data: data)
          self.squareImageView.image = image
        }
      }
    })
    downloadTask.resume()
  }
  
  
}
