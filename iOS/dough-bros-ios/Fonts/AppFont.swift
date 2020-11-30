//
//  CustomFonts.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-28.
//

import SwiftUI

extension UIFont {
  
  static func customFont() -> UIFont {
    return UIFont(name: CustomFontWeight.medium.rawValue, size: UIFont.systemFontSize)!
  }
  static func customFont(ofSize size: CGFloat, weight: CustomFontWeight = .medium) -> UIFont {
    return UIFont(name: weight.rawValue, size: size)!
  }
}

enum CustomFontWeight: String {
  case extraBold = "Airbnb Cereal App Extra Bold"
  case black = "Airbnb Cereal App Black"
  case bold = "Airbnb Cereal App Bold"
  case medium = "Airbnb Cereal App Medium"
  case light = "Airbnb Cereal App Light"
}
