//
//  File.swift
//  dough-bros-ios
//
//  Created by Carlos Georgescu on 13/02/21.
//
import UIKit

extension UIImage {
  static func localImage(_ name: String, template: Bool = false) -> UIImage {
    var image = UIImage(named: name)!
    if template {
      image = image.withRenderingMode(.alwaysTemplate)
    }
    return image
  }
}
