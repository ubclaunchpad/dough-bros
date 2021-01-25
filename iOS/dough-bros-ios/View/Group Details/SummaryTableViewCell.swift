//
//  SummaryTableViewCell.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-10-27.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    let userImage: UIImageView = {
        // let image = UIImage(named: "SampleImage.png")
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(hex: Styles.init().colourList.randomElement()!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let userName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return name
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // setupCellImage()
        contentView.addSubview(userImage)
        NSLayoutConstraint.activate([
            userImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            userImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 50),
            userImage.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        // setupCellDetail
        contentView.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10),
            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            userName.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
