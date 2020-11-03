//
//  GroupsViewController.swift
//  dough-bros-ios
//
//  Created by Main on 2020-11-01.
//
import UIKit
import Foundation

class GroupsViewController: UIViewController {
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = false
      
      self.view.addSubview(tableView)
      
      NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
      
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
      
    

}
