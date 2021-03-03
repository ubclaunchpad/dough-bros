//
//  GroupsCollectionViewCell.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import UIKit
import AlanYanHelpers
class AddExpenseCollectionViewCell: UICollectionViewCell {
    
    var friend: User? {
        didSet {
            setupModel()
        }
    }
    private let profilePictureView = UIImageView()
    
    private let userlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: 0x2C365A)
        label.text = "user"
        label.font = UIFont.customFont(ofSize: 14)
        return label
    }()
    
    private(set) var checkbox: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(systemName: "checkmark.circle")
        imageview.tintColor = UIColor(hex: 0x6BAED8)
        return imageview
    }()
    
    private(set) var amountOwed: UITextField = {
        let amount = UITextField()
        amount.keyboardType = .decimalPad
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.textColor = UIColor(hex: 0x2C365A)
        amount.text = "$0"
        amount.font = UIFont.customFont(ofSize: 14)
        return amount
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.setColor(UIColor(hex: 0xD8D8D8)).addCorners(30)
        
        checkbox.setSuperview(contentView).addLeading(constant: 10).addWidth(withConstant: 20).addHeight(withConstant: 20).addCenterY()
        
        profilePictureView.setSuperview(contentView).addLeading(anchor: checkbox.trailingAnchor, constant: 10).addCorners(25).addWidth(withConstant: 50).addHeight(withConstant: 50).addCenterY()
        
        
        profilePictureView.contentMode = .scaleAspectFill
        
        contentView.addSubview(amountOwed)
        NSLayoutConstraint.activate([
            amountOwed.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            amountOwed.centerYAnchor.constraint(equalTo: profilePictureView.centerYAnchor)
        ])
        amountOwed.addDoneButtonOnKeyboard()
        
        contentView.addSubview(userlabel)
        NSLayoutConstraint.activate([
            userlabel.trailingAnchor.constraint(lessThanOrEqualTo: amountOwed.leadingAnchor, constant: -10),
            userlabel.leadingAnchor.constraint(equalTo: profilePictureView.trailingAnchor, constant: 15),
            userlabel.centerYAnchor.constraint(equalTo: profilePictureView.centerYAnchor)
        ])
    }
    
    private func setupModel() {
        guard let friend = friend else { return }
        
        profilePictureView.image = UIImage(named: friend.first_name) ?? UIImage(named: "duck")
        profilePictureView.tintColor = .white
        userlabel.text = friend.first_name
        
    }
    
    func updateCell(for type: AddExpenseView.SelectedState) {
        if type == .customSplit {
            checkbox.userDefinedConstraintDict["width"]?.constant = 0
            amountOwed.isUserInteractionEnabled = true
            amountOwed.textColor = UIColor(hex: 0x2C365A)
        } else {
            checkbox.userDefinedConstraintDict["width"]?.constant = 20
            amountOwed.isUserInteractionEnabled = false
            amountOwed.textColor = .gray
        }
        
        layoutIfNeeded()
    }
}


extension UITextField {
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
