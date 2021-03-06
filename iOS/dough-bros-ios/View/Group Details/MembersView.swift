//
//  MembersView.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2021-03-22.
//

import UIKit

class MembersView: UIView {

    // MARK: - Subviews -
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private(set) var backButton: UIButton = {
        let back = UIButton(type: .system)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.contentHorizontalAlignment = .fill
        back.contentVerticalAlignment = .fill
        back.imageView?.contentMode = .scaleAspectFit
        back.setImage(UIImage(named: "BackButton"), for: .normal)
        back.tintColor = .black
        return back
    }()
    
    private(set) var editButton: UIButton = {
        let edit = UIButton(type: .system)
        edit.translatesAutoresizingMaskIntoConstraints = false
        edit.contentHorizontalAlignment = .fill
        edit.contentVerticalAlignment = .fill
        edit.imageView?.contentMode = .scaleAspectFit
        edit.setImage(UIImage(named: "EditButton"), for: .normal)
        edit.tintColor = .black
        return edit
    }()
    
    private(set) var groupImage: UIImageView = {
        // let image = UIImage(named: "SampleImage.png")
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(hex: Styles.init().colourList.randomElement()!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) var groupName: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "Enter Group Name"
        label.textColor = .black
        label.font = UIFont.customFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.backgroundColor = UIColor(hex: 0xF2F2F2)  //FFFFFF
        label.addCorners(20)
        label.setLeftPaddingPoints(15)
        label.setRightPaddingPoints(15)
        return label
    }()
    
    private var summaryLabel: UILabel = {
        let summaryLabel = UILabel()
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.textColor = .black
        summaryLabel.text = "Members"
        summaryLabel.font = UIFont.customFont(ofSize: 16, weight: .bold)
        return summaryLabel
    }()
    
    private(set) var summaryView: UITableView = {
        let summary = UITableView()
        summary.translatesAutoresizingMaskIntoConstraints = false
        summary.register(AddGroupTableViewCell.self, forCellReuseIdentifier: AddGroupTableViewCell.className)
        summary.rowHeight = 70
        summary.estimatedRowHeight = 70
        summary.isScrollEnabled = false
        summary.separatorColor = .clear
        summary.allowsSelection = false
        return summary
    }()

    private(set) var addExpenseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Member", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: 0x6BAED8)
        button.titleLabel?.font = UIFont.customFont(ofSize: 16)
        button.addCorners(20)
        return button
    }()
    
    //MARK: - Initializers -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // REQUIRED implementation for loading views from cached storyboards since we implemented another init we need to cover the required inits, we will never use this method though
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    
    // MARK: - Setup -
    private func setupView() {
        backgroundColor = .white
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
        
        // setupHeaderView()
        contentView.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        contentView.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 20),
            editButton.heightAnchor.constraint(equalToConstant: 20),
            editButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
        // setupImage()
        contentView.addSubview(groupImage)
        NSLayoutConstraint.activate([
            groupImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            groupImage.topAnchor.constraint(equalTo: backButton.topAnchor, constant: 50),
            groupImage.widthAnchor.constraint(equalToConstant: 100),
            groupImage.heightAnchor.constraint(equalToConstant: 100)
        ])

        // setupName()
        contentView.addSubview(groupName)
        NSLayoutConstraint.activate([
            groupName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            groupName.topAnchor.constraint(equalTo: groupImage.bottomAnchor, constant: 10)
        ])

        // setupAddExpenses()
        contentView.addSubview(addExpenseButton)
        NSLayoutConstraint.activate([
            addExpenseButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addExpenseButton.widthAnchor.constraint(equalToConstant: 150),
            addExpenseButton.heightAnchor.constraint(equalToConstant: 40),
            addExpenseButton.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 20)
        ])
        
        // setupSummary()
        contentView.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: addExpenseButton.bottomAnchor, constant: 30),
            summaryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 40)
        ])
        contentView.addSubview(summaryView)
        NSLayoutConstraint.activate([
            summaryView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            summaryView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 5),
            summaryView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            summaryView.heightAnchor.constraint(equalToConstant: summaryView.rowHeight * CGFloat(6)), // 5 cells high
            summaryView.leftAnchor.constraint(equalTo: summaryLabel.leftAnchor),
            summaryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
        
    }
}

