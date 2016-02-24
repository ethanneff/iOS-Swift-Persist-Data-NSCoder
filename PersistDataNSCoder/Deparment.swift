//
//  Deparment.swift
//  PersistDataNSCoder
//
//  Created by Ethan Neff on 2/23/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import Foundation

class Department: NSObject, NSCoding {
  // PROPERTIES
  var deptName = ""
  var managerName = ""
  var task: [Assignment]?
  
  // INIT
  init?(deptName: String, managerName: String, task: [Assignment]?) {
    self.deptName = deptName
    self.managerName = managerName
    self.task = task
    
    super.init()
    
    if deptName.isEmpty || managerName.isEmpty {
      return nil
    }
  }
  
  // SAVE
  static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("department")
  
  struct PropertyKey {
    static let deptName = "deptName"
    static let managerName = "mngName"
    static let task = "taskArray"
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(deptName, forKey: PropertyKey.deptName)
    aCoder.encodeObject(managerName, forKey: PropertyKey.managerName)
    aCoder.encodeObject(task, forKey: PropertyKey.task)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let deptName = aDecoder.decodeObjectForKey(PropertyKey.deptName) as! String
    let managerName = aDecoder.decodeObjectForKey(PropertyKey.managerName) as! String
    let task = aDecoder.decodeObjectForKey(PropertyKey.task) as? [Assignment]
    self.init(deptName: deptName, managerName: managerName, task: task)
  }
}
