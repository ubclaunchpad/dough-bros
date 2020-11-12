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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.setColor(UIColor(hex: 0xD8D8D8)).addCorners(30)
        profilePictureView.setSuperview(contentView).addTop(constant: 10).addCenterX().addCorners(25).addWidth(withConstant: 50).addHeight(withConstant: 50)
        
        profilePictureView.contentMode = .scaleAspectFill
        
        contentView.addSubview(userlabel)
        NSLayoutConstraint.activate([
            userlabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            userlabel.topAnchor.constraint(equalTo: profilePictureView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupModel() {
        guard let friend = friend else { return }
        
        profilePictureView.image = UIImage(named: friend.name) ?? UIImage(named: "duck")
        profilePictureView.tintColor = .white
        userlabel.text = friend.name
    }
}
