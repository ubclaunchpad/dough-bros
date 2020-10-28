//
//  GroupDetailsView.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit

class GroupDetailsView: UIView, UITableViewDataSource, UITableViewDelegate {
    // TEMP DEV DATA
    var summaryStuff = ["Alex owes you $100", "Bob owes you $300", "Charlie has settled his payment", "Daniel owes you $4000"]
    var activityStuff = ["Alex paid you $220", "Bob paid you $500", "John paid you $220", "Steven paid you $500", "Joe paid you $220", "Charles paid you $500"]

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
    
    private var backButton: UIButton = {
        let back = UIButton(type: .system)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.contentHorizontalAlignment = .fill
        back.contentVerticalAlignment = .fill
        back.imageView?.contentMode = .scaleAspectFit
        back.setImage(UIImage(systemName: "chevron.left.square.fill"), for: .normal)
        back.tintColor = .black
        return back
    }()
    
    private var editButton: UIButton = {
        let edit = UIButton(type: .system)
        edit.translatesAutoresizingMaskIntoConstraints = false
        edit.contentHorizontalAlignment = .fill
        edit.contentVerticalAlignment = .fill
        edit.imageView?.contentMode = .scaleAspectFit
        edit.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        edit.tintColor = .black
        return edit
    }()
    
    private var groupImage: UIImageView = {
        let image = UIImage(named: "SampleImage.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var groupName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black
        name.text = "West Coast Trip 2021"
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return name
    }()
    
    private var summaryLabel: UILabel = {
        let summaryLabel = UILabel()
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.textColor = .black
        summaryLabel.text = "Summary"
        summaryLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return summaryLabel
    }()
    
    private var summaryView: UITableView = {
        let summary = UITableView()
        summary.translatesAutoresizingMaskIntoConstraints = false
        summary.register(SummaryTableViewCell.self, forCellReuseIdentifier: "summaryCell")
        summary.rowHeight = 50
        summary.estimatedRowHeight = 50
        summary.isScrollEnabled = false
        return summary
    }()
    
    private var activityLabel: UILabel = {
        let activityLabel = UILabel()
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        activityLabel.textColor = .black
        activityLabel.text = "Activity"
        activityLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return activityLabel
    }()
    
    private var activityView: UITableView = {
        let activity = UITableView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.register(ActivityTableViewCell.self, forCellReuseIdentifier: "activityCell")
        activity.rowHeight = 70
        activity.estimatedRowHeight = 70
        activity.isScrollEnabled = false
        return activity
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
    
    // Setup Tableview for Either Summary or Activity
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == summaryView) {
            return summaryStuff.count
        } else {
            return activityStuff.count
        }
    }
    
    // Setup Tableview cells for either summary or activity
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == summaryView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! SummaryTableViewCell
            cell.userName.text = summaryStuff[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
            cell.userName.text = activityStuff[indexPath.row]
            
            return cell
        }
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
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        contentView.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30),
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

        // setupSummary()
        contentView.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 30),
            summaryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        contentView.addSubview(summaryView)
        summaryView.dataSource = self
        NSLayoutConstraint.activate([
            summaryView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            summaryView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 5),
            summaryView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            summaryView.heightAnchor.constraint(equalToConstant: summaryView.rowHeight * CGFloat(summaryStuff.count))
        ])

        // setupActivity()
        contentView.addSubview(activityLabel)
        NSLayoutConstraint.activate([
            activityLabel.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 30),
            activityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        contentView.addSubview(activityView)
        activityView.dataSource = self
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityView.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 5),
            activityView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            activityView.heightAnchor.constraint(equalToConstant: activityView.rowHeight * CGFloat(activityStuff.count)),
            activityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
}
