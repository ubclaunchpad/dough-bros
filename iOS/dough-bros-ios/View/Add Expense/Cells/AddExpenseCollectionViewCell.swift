//
//  GroupsCollectionViewCell.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import UIKit
import AlanYanHelpers
class AddExpenseCollectionViewCell: UICollectionViewCell {
    
    var friend: Friend? {
        didSet {
            setupModel()
        }
    }
    private let profilePictureView = UIImageView()
    
    private let userlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "user"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private(set) var checkbox: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(systemName: "checkmark.circle")
        return imageview
    }()
    
    private(set) var amountOwed: UITextField = {
        let amount = UITextField()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.textColor = .black
        amount.placeholder = "$0"
        amount.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        
        contentView.addSubview(checkbox)
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            checkbox.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        profilePictureView.setSuperview(contentView).addTop(constant: 10).addLeading(anchor: checkbox.trailingAnchor, constant: 10).addCorners(25).addWidth(withConstant: 50).addHeight(withConstant: 50).addCenterY()
        
//        contentView.addSubview(profilePictureView)
//        NSLayoutConstraint.activate([
//            profilePictureView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            profilePictureView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            profilePictureView.heightAnchor.constraint(equalToConstant: 50)
//        ])
        
        profilePictureView.contentMode = .scaleAspectFill
        
        contentView.addSubview(userlabel)
        NSLayoutConstraint.activate([
            userlabel.leadingAnchor.constraint(equalTo: profilePictureView.trailingAnchor, constant: 15),
            userlabel.centerYAnchor.constraint(equalTo: profilePictureView.centerYAnchor)
        ])
        
        contentView.addSubview(amountOwed)
        NSLayoutConstraint.activate([
            amountOwed.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            amountOwed.centerYAnchor.constraint(equalTo: profilePictureView.centerYAnchor)
        ])
    }
    
    private func setupModel() {
        guard let friend = friend else { return }
        
        profilePictureView.image = UIImage(named: friend.name) ?? UIImage(named: "duck")
        profilePictureView.tintColor = .white
        userlabel.text = friend.name
    }
}
