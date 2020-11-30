//
//  DBStackView.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-26.
//

import UIKit

class DBStackView: UIStackView {

    override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, spacing: CGFloat? = nil) {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.axis = axis
            self.alignment = alignment
            self.distribution = .fillProportionally
            if let spacing = spacing {
                self.spacing = spacing
            }
        }
}
