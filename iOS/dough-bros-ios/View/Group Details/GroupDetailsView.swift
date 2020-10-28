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
    var activityStuff = ["Alex paid you $220", "Bob paid you $500"]

    // MARK: - Subviews -
    private var groupImage: UIImageView = {
        let image = UIImage(named: "SampleImage.png")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var groupName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .orange
        name.text = "West Coast Trip 2021"
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return name
    }()
    
    private var summaryLabel: UILabel = {
        let summaryName = UILabel()
        summaryName.translatesAutoresizingMaskIntoConstraints = false
        summaryName.textColor = .black
        summaryName.text = "Summary"
        summaryName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return summaryName
    }()
    
    private var activityLabel: UILabel = {
        let activityName = UILabel()
        activityName.translatesAutoresizingMaskIntoConstraints = false
        activityName.textColor = .black
        activityName.text = "Activity"
        activityName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return activityName
    }()
    
    // make UITableView custom class w/ images when design is confirmed
    private var summaryView: UITableView = {
        let summary = UITableView()
        summary.translatesAutoresizingMaskIntoConstraints = false
        summary.register(UITableViewCell.self, forCellReuseIdentifier: "summaryCell")
        summary.separatorColor = .clear
        return summary
    }()
    
    private var activityView: UITableView = {
        let activity = UITableView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.register(UITableViewCell.self, forCellReuseIdentifier: "activityCell")
        activity.separatorColor = .clear
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath)
            cell.textLabel?.text = summaryStuff[indexPath.row]
            cell.textLabel?.textColor = .orange
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
            cell.textLabel?.text = activityStuff[indexPath.row]
            cell.textLabel?.textColor = .orange
            
            return cell
        }
    }
    
    // MARK: - Setup -
    private func setupView() {
        backgroundColor = .white
        
        // setupImage()
        addSubview(groupImage)
        NSLayoutConstraint.activate([
            groupImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            groupImage.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            groupImage.widthAnchor.constraint(equalToConstant: 100),
            groupImage.heightAnchor.constraint(equalToConstant: 100)
        ])

        // setupName()
        addSubview(groupName)
        NSLayoutConstraint.activate([
            groupName.centerXAnchor.constraint(equalTo: centerXAnchor),
            groupName.topAnchor.constraint(equalTo: groupImage.bottomAnchor, constant: 20)
        ])

        // setupSummary()
        addSubview(summaryView)
        summaryView.dataSource = self
        NSLayoutConstraint.activate([
            summaryView.centerXAnchor.constraint(equalTo: centerXAnchor),
            summaryView.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 70),
            summaryView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            summaryView.heightAnchor.constraint(equalToConstant: 150)
        ])

        // setupActivity()
        addSubview(activityView)
        activityView.dataSource = self
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 70),
            activityView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            activityView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // setup summary and activity labels
        addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            summaryLabel.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 30),
            summaryLabel.leftAnchor.constraint(equalTo: summaryView.leftAnchor)
        ])
        
        addSubview(activityLabel)
        NSLayoutConstraint.activate([
            activityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityLabel.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 30),
            activityLabel.leftAnchor.constraint(equalTo: activityView.leftAnchor)
        ])
        
    }
}
