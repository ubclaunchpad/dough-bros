//
//  GroupTableViewCell.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import UIKit
import AlanYanHelpers

class GroupTableViewCell: UITableViewCell {
    
    var group: Group? {
        didSet {
            setupModel()
        }
    }
    
    private var wrapperView = UIView()
    private var groupProfilePictureView = ContentFitImageView()
    
    private var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "10$"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var oweLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        wrapperView.setSuperview(contentView).addTop(constant: 5).addBottom(constant: -5).addWidth(anchor: contentView.widthAnchor).setColor(UIColor(hex: 0xD8D8D8)).addCorners(10)
        
        groupProfilePictureView.setSuperview(wrapperView).addLeading(constant: 10).addCenterY().addWidth(withConstant: 40).addHeight(withConstant: 40).addCorners(20).setColor(.lightGray)
        
        amountLabel.setSuperview(wrapperView).addTrailing(constant: -10).addCenterY()
        
        nameLabel.setSuperview(wrapperView).addLeading(anchor: groupProfilePictureView.trailingAnchor, constant: 10).addCenterY()
        nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -5).isActive = true
        
        oweLabel.setSuperview(wrapperView).addBottom(anchor: amountLabel.topAnchor).addTrailing(anchor: amountLabel.trailingAnchor)
    }
    
    private func setupModel() {
        guard let group = group else {
            return
        }
        
        groupProfilePictureView.image = group.image ?? UIImage(systemName: "person.crop.circle.fill")
        groupProfilePictureView.tintColor = .white
        nameLabel.text = group.name
        amountLabel.text = "$\(group.amount)"
        oweLabel.text = group.youOwe ? "You Owe" : ""
    }
}
