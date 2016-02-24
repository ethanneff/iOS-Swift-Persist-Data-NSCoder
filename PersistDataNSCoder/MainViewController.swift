//
//  testViewController.swift
//  Improve
//
//  Created by Ethan Neff on 2/23/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  // MARK: - PROPERTIES
  var viewData: Department?
  @IBOutlet weak var output: UILabel!
  
  
  
  // MARK: - LOAD
  override func viewDidLoad() {
    super.viewDidLoad()
    output.text = ""
  }
  
  
  
  // MARK: - PERSIST DATA
  @IBAction func load(sender: AnyObject) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
      if let load = NSKeyedUnarchiver.unarchiveObjectWithFile(Department.ArchiveURL.path!) as? Department {
        self.viewData = load
      } else {
        print("failed to load")
      }
    })
  }
  
  @IBAction func save(sender: AnyObject) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
      if let data = self.viewData {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(data, toFile: Department.ArchiveURL.path!)
        if !isSuccessfulSave {
          print("Failed to save meals...")
        }
      } else  {
        print("no data to save")
      }
    })
  }
  
  
  
  // MARK: - VIEW DATA
  @IBAction func output(sender: AnyObject) {
    if let results = viewData {
      let str = "department: \(output) \n deptName: \(results.deptName) \n managerName: \(results.managerName) \n task: \(results.task?.count) \n"
      print(str)
      output.text = str
    } else {
      print(viewData)
      output.text = "nil"
    }
  }
  
  @IBAction func create(sender: AnyObject) {
    if let assign1 = Assignment(title: "one", notes: "blah"),
      let assign2 = Assignment(title: "two", notes: "yulp"),
      let dept = Department(deptName: "three", managerName: "bob", task: [assign1, assign2]) {
        viewData = dept
    }
  }
  
  @IBAction func clear(sender: AnyObject) {
    viewData = nil
  }
}
