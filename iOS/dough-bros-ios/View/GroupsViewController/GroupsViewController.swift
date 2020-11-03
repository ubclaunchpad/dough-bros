//
//  GroupsViewController.swift
//  dough-bros-ios
//
//  Created by Main on 2020-11-01.
//
import UIKit
import Foundation

class GroupsViewController: UIViewController {
    
    
    private(set) var openGroupViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Groups Button", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.addSubview(openGroupViewButton)
      
      self.view.addSubview(tableView)
      
      NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      ])
      
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
      
    

}
