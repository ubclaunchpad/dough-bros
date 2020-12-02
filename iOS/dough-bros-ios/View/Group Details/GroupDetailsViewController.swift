//
//  GroupDetailsViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit
import Firebase
import Combine

class GroupDetailsViewController: UIViewController {
    
    var groupObj:GroupObj?
    private var paymentViewModel = PaymentViewModel()
    private var cancellableSet: Set<AnyCancellable> = []

    private var groupDetailsView: GroupDetailsView {
        return view as! GroupDetailsView
    }
    
    // MARK: - View Life Cycle -
    deinit {
        cancellableSet.forEach({$0.cancel()})
    }
    override func loadView() {
        super.loadView()
        view = GroupDetailsView()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        groupDetailsView.summaryView.delegate = self
        groupDetailsView.summaryView.dataSource = self
        groupDetailsView.activityView.delegate = self
        groupDetailsView.activityView.dataSource = self
        setupViewModel()
        
//        if (groupObj != nil && groupObj?.image_uri != "") {
//            let url = URL(string: groupObj!.image_uri)
//            let data = try? Data(contentsOf: url!)
//            groupDetailsView.groupImage.image = UIImage(data: data!)
//        }
        groupDetailsView.groupName.text = groupObj?.group_name == "" ? "Untitled Group" : groupObj?.group_name
        groupDetailsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        groupDetailsView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        groupDetailsView.addExpenseButton.addTarget(self, action: #selector(addExpenseTapped), for: .touchUpInside)
        groupDetailsView.settleDebtButton.addTarget(self, action: #selector(settleDebtTapped), for: .touchUpInside)

    }
    
    private func setupViewModel() {
        paymentViewModel.$payments.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.groupDetailsView.summaryView.reloadData()
        }.store(in: &cancellableSet)
        
        paymentViewModel.$activity.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.groupDetailsView.activityView.reloadData()
        }.store(in: &cancellableSet)
        
        paymentViewModel.fetchData(groupID: groupObj!.group_id)
        paymentViewModel.fetchSettledData(creatorID: groupObj!.creator_id, groupID: groupObj!.group_id)
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
        //TODO: Pass group members through
        present(addExpenseVC, animated: true)
    }
    
    @objc private func settleDebtTapped() {
        let settleDebtVC = SettleDebtViewController()
        
        settleDebtVC.groupObj = groupObj
        navigationController?.pushViewController(settleDebtVC, animated: true)
    }
}

extension GroupDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    // Setup Tableview for Either Summary or Activity
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == groupDetailsView.summaryView) {
            return paymentViewModel.payments.count
        } else {
            return paymentViewModel.activity.count
        }
    }
    
    // Setup Tableview cells for either summary or activity
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == groupDetailsView.summaryView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! SummaryTableViewCell
            cell.userName.text = paymentViewModel.payments[indexPath.row].first_name + " owes you $" + String(paymentViewModel.payments[indexPath.row].amount)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
            cell.userName.text = paymentViewModel.activity[indexPath.row].first_name + " paid you $" + String(paymentViewModel.activity[indexPath.row].amount)
            
            return cell
        }
    }
}
