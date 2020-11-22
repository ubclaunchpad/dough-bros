//
//  GroupDetailsViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit

class GroupDetailsViewController: UIViewController {
    
    var groupObj:GroupObj?

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
        if (groupObj != nil && groupObj?.image_uri != "") {
            let url = URL(string: groupObj!.image_uri)
            let data = try? Data(contentsOf: url!)
            groupDetailsView.groupImage.image = UIImage(data: data!)
        }
        groupDetailsView.groupName.text = groupObj?.group_name == "" ? "Untitled Group" : groupObj?.group_name
        groupDetailsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        groupDetailsView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        groupDetailsView.addExpenseButton.addTarget(self, action: #selector(addExpenseTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        print("edit button presesed")
    }
    
    @objc private func addExpenseTapped() {
        print("add expense tapped")
        let addExpenseVC = AddExpenseViewController()
        
        present(addExpenseVC, animated: true)
    }
}
