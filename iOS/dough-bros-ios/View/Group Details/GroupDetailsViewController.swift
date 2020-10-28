//
//  GroupDetailsViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit

class GroupDetailsViewController: UIViewController {

    private var groupDetailsView: GroupDetailsView {
        return view as! GroupDetailsView
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        
        view = GroupDetailsView()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupDetailsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        groupDetailsView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        print("back button presesed")
        // pop Groups tab later when finalized w/ nav controller
    }
    
    @objc private func editButtonTapped() {
        print("edit button presesed")
    }
}
