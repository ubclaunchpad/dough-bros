//
//  GroupsViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit

class GroupsViewController: UIViewController {

    private var groupsView: GroupsView {
        return view as! GroupsView
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        view = GroupsView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
