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
