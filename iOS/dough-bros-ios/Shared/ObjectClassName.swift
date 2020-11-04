//
//  ObjectClassName.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import Foundation

extension NSObject {
  @objc var className: String {
    return String(describing: type(of: self))
  }
  
  @objc class var className: String {
    return String(describing: self)
  }
}
