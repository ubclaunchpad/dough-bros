//
//  GroupTableViewCell.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import UIKit
import AlanYanHelpers
import Firebase
import FirebaseUI

class GroupTableViewCell: UITableViewCell {
    
    let storage = Storage.storage()
    
    var group: GroupObj? {
        didSet {
            setupModel()
        }
    }
    
    private var wrapperView = UIView()
    private var groupProfilePictureView = ContentFitImageView()
    
    private var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "10$"
        label.textColor = UIColor(hex: 0x2C365A)
        label.font = UIFont.customFont(ofSize: 11, weight: .medium)
        return label
    }()
    
    private var oweLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x2C365A)
        label.font = UIFont.customFont(ofSize: 10, weight: .light)
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = UIColor(hex: 0x2C365A)
        label.font = UIFont.customFont(ofSize: 14, weight: .medium)
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
        wrapperView.setSuperview(contentView).addTop(constant: 5).addBottom(constant: -5).addWidth(anchor: contentView.widthAnchor).setColor(UIColor(hex: 0xE1EEEE)).addCorners(32)
        
        groupProfilePictureView.setSuperview(wrapperView).addLeading(constant: 15).addCenterY().addWidth(withConstant: 56).addHeight(withConstant: 56).addCorners(28).setColor(.lightGray)
        
        amountLabel.setSuperview(wrapperView).addTrailing(constant: -15).addCenterY()
        
        nameLabel.setSuperview(wrapperView).addLeading(anchor: groupProfilePictureView.trailingAnchor, constant: 15).addCenterY()
        nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -5).isActive = true
        
        oweLabel.setSuperview(wrapperView).addBottom(anchor: amountLabel.topAnchor).addTrailing(anchor: amountLabel.trailingAnchor)
    }
    
    public func setupModel() {
        guard let group = group else {
            return
        }
        
//        if (group.image_uri == "") {
//            groupProfilePictureView.image = UIImage(systemName: "person.crop.circle.fill")
//        } else {
//            let url = URL(string: group.image_uri)
//            let data = try? Data(contentsOf: url!)
//            groupProfilePictureView.image = UIImage(data: data!)
//        }
        
        
        // Get Image
        loadImage()
        groupProfilePictureView.backgroundColor = UIColor(hex: Styles.init().colourList.randomElement()!)
        groupProfilePictureView.tintColor = .white
        groupProfilePictureView.contentMode = .scaleAspectFill
        
        nameLabel.text = group.group_name == "" ? "Untitled Group" : group.group_name
        amountLabel.text = "$\(group.amount)"
        oweLabel.text = Auth.auth().currentUser?.uid != group.creator_id ? "You Owe" : ""
    }
    
    public func loadImage() {
        guard let group = group else {
            return
        }
        
        let storageRef = storage.reference().child("GroupPicture").child(String(group.group_id) + ".jpg")
        groupProfilePictureView.sd_setImage(with: storageRef)
    }
}
