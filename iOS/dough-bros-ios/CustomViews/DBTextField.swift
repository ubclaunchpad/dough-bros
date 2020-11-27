//
//  DBTextField.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-26.
//

import UIKit

class DBTextField: UITextField {

    let bottomView = UIView()
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        init(placeholderText: String, textStyle: UIFont.TextStyle) {
            super.init(frame: .zero)
            attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            font = UIFont.preferredFont(forTextStyle: textStyle)
            
            configure()
        }
        
        private func configure() {
            translatesAutoresizingMaskIntoConstraints = false
            textColor = .black
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: frame.height))
            leftViewMode = .always
            
            bottomView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(bottomView)
            NSLayoutConstraint.activate([
                bottomView.heightAnchor.constraint(equalToConstant: 1),
                bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
                bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
                bottomView.topAnchor.constraint(equalTo: bottomAnchor, constant: 8)
            ])
            bottomView.backgroundColor = UIColor.white
            
        }
        
        
        func styleBottomBorder(color: UIColor) {
            bottomView.backgroundColor = color
        }
}
