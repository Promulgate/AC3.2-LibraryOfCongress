//
//  Book.swift
//  LibraryOfCongress
//
//  Created by Eric Chang on 10/30/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

internal enum LibraryParseError: Error {
  case results, title, images, subjectList
}

struct Book {
  internal var title: String
  internal var thumbnail: String
  internal var fullImage: String
  internal var subjectList: [String]?
  
  static func parseData (with data: Data) -> [Book]? {
    var books: [Book]? = []
    
    do {
      let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
      
      guard let response = jsonData as? [String:AnyObject],
        let results = response["results"] as? [AnyObject]
        else { throw LibraryParseError.results }
      
      for book in results {
      
        guard let title = book["title"] as? String
          else { throw LibraryParseError.title }
        
        guard let images = book["image"] as? [String:String],
          let thumbnail = images["thumb"],
          let fullImage = images["square"]
          else { throw LibraryParseError.images }
        
//        guard let subjectList = book["subjects"] as? [String]?
//          else { throw LibraryParseError.subjectList }
        
        
        let validBook = Book(title: title,
                             thumbnail: thumbnail,
                             fullImage: fullImage,
                             subjectList: book["subjects"] as? [String] ?? ["N/A"])
        
        books?.append(validBook)
      }
    }
    catch LibraryParseError.results {
      print("Error: json results")
    }
    catch LibraryParseError.title {
      print("Error: title casting")
    }
    catch LibraryParseError.images {
      print("Error: images casting")
    }
    catch {
      print("Error: subject list casting")
    }
    return books
  }
  
  
  
}
