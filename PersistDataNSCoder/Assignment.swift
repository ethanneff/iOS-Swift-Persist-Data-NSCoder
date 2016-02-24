//
//  Assignment.swift
//  PersistDataNSCoder
//
//  Created by Ethan Neff on 2/23/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import Foundation

class Assignment: NSObject, NSCoding {
  // PROPERTIES
  var title = ""
  var notes = ""
  
  init?(title: String, notes: String) {
    self.title = title
    self.notes = notes
    
    super.init()
    
    if title.isEmpty || notes.isEmpty {
      return nil
    }
  }
  
  // SAVE
  struct PropertyKey {
    static let title = "title"
    static let notes = "notes"
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(title, forKey: PropertyKey.title)
    aCoder.encodeObject(notes, forKey: PropertyKey.notes)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let title = aDecoder.decodeObjectForKey(PropertyKey.title) as! String
    let notes = aDecoder.decodeObjectForKey(PropertyKey.notes) as! String
    self.init(title: title, notes: notes)
  }
}