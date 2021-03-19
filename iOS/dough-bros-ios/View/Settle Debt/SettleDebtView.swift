//
//  SettleDebtView.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-27.
//

import UIKit

class SettleDebtView: UIView {

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
    
    private(set) var groupImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(hex: Styles.init().colourList.randomElement()!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.contentMode = .center
        return imageView
    }()
    
    private(set) var groupName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black
        name.text = "West Coast Trip 2021"
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return name
    }()
    
    private var summaryLabel: UILabel = {
        let summaryLabel = UILabel()
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.textColor = .black
        summaryLabel.text = "Which balance do you want to settle?"
        summaryLabel.numberOfLines = 2
        summaryLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return summaryLabel
    }()
    
    private(set) var summaryView: UITableView = {
        let summary = UITableView()
        summary.translatesAutoresizingMaskIntoConstraints = false
        summary.register(SummaryTableViewCell.self, forCellReuseIdentifier: "summaryCell")
        summary.rowHeight = 70
        summary.estimatedRowHeight = 70
        summary.isScrollEnabled = false
        summary.separatorColor = .clear
        return summary
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
        
        // setupSummary()
        contentView.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 30),
            summaryLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
        let numsRowVisible = 4
        contentView.addSubview(summaryView)
        NSLayoutConstraint.activate([
            summaryView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            summaryView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 15),
            summaryView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            summaryView.heightAnchor.constraint(equalToConstant: summaryView.rowHeight * CGFloat(numsRowVisible)),
            summaryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            summaryView.leftAnchor.constraint(equalTo: summaryLabel.leftAnchor)
        ])
        
    }
}
