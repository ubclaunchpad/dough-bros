//
//  GroupsCollectionViewCell.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import UIKit
import AlanYanHelpers
class GroupsCollectionViewCell: UICollectionViewCell {
    
    var friend: Friend? {
        didSet {
            setupModel()
        }
    }
    private let profilePictureView = ContentFitImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.setColor(UIColor(hex: 0xD8D8D8)).addCorners(30)
        profilePictureView.setSuperview(contentView).addCenterY().addCenterX().addWidth(constant: -5).addHeight(constant: -5).addCorners(25)
    }
    
    private func setupModel() {
        guard let friend = friend else { return }
        
        profilePictureView.image = UIImage(named: friend.name) ?? UIImage(systemName: "person.crop.circle.fill")
        profilePictureView.tintColor = .white
    }
}
