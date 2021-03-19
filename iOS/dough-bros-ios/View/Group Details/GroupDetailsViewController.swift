//
//  GroupDetailsViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit
import Firebase
import Combine

class GroupDetailsViewController: UIViewController, UITextFieldDelegate {
    
    var groupObj: GroupObj?
    private var paymentViewModel = PaymentViewModel()
    private var cancellableSet: Set<AnyCancellable> = []
    private var isOwner = false
    private var groupMembers = [User]()

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
        
        if (Auth.auth().currentUser?.uid == groupObj?.creator_id) {
            // Owner
            groupDetailsView.settleDebtButtonMiddle.isHidden = true
            isOwner = true
        } else {
            // User
            groupDetailsView.settleDebtButton.isHidden = true
            groupDetailsView.addExpenseButton.isHidden = true
        }
        
        setupViewModel()
        setupTextField()
        
//        if (groupObj != nil && groupObj?.image_uri != "") {
//            let url = URL(string: groupObj!.image_uri)
//            let data = try? Data(contentsOf: url!)
//            groupDetailsView.groupImage.image = UIImage(data: data!)
//        }
        let groupName = String((groupObj?.group_name.removingPercentEncoding)!)
        
        groupDetailsView.groupName.text = groupObj?.group_name == "" ? "Untitled Group" : groupName
        groupDetailsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        groupDetailsView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        groupDetailsView.addExpenseButton.addTarget(self, action: #selector(addExpenseTapped), for: .touchUpInside)
        groupDetailsView.settleDebtButton.addTarget(self, action: #selector(settleDebtTapped), for: .touchUpInside)
        groupDetailsView.settleDebtButtonMiddle.addTarget(self, action: #selector(settleDebtTapped), for: .touchUpInside)
        
        self.groupMembers = GroupEndpoints.getUsersInGroup(groupID: groupObj!.group_id)
    }
    
    private func setupViewModel() {
        paymentViewModel.$payments.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.groupDetailsView.summaryView.reloadData()
        }.store(in: &cancellableSet)
        
        paymentViewModel.$activity.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.groupDetailsView.activityView.reloadData()
        }.store(in: &cancellableSet)
        
        paymentViewModel.fetchData(groupID: groupObj!.group_id)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        print("edit button presesed")
    }
    
    private func setupTextField() {
        groupDetailsView.groupName.delegate = self
        groupDetailsView.groupName.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        print("Text changed: " + textField.text!)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: textField)
                    perform(#selector(self.reload(_:)), with: textField, afterDelay: 0.75)
    }
            
    @objc func reload(_ textField: UITextField) {
        guard let name = textField.text, name.trimmingCharacters(in: .whitespaces) != "" else {
            print("group name empty")
            return
        }
        print(groupObj!.group_id)
        print("group name: " + name)
        GroupEndpoints.setGroupName(groupID: groupObj!.group_id, groupName: name)
        //groupDetailsView.groupName.reloadData()
    }
    
    @objc private func addExpenseTapped() {
        print("add expense tapped")
        let addExpenseVC = AddExpenseViewController()
        addExpenseVC.groupMembers = self.groupMembers
        addExpenseVC.groupObj = self.groupObj
        present(addExpenseVC, animated: true)
    }
    
    @objc private func settleDebtTapped() {
        let settleDebtVC = SettleDebtViewController()
        settleDebtVC.groupObj = groupObj
        settleDebtVC.isOwner = isOwner
        
        settleDebtVC.debtList = paymentViewModel.payments.filter({$0.is_settled == 0 && ($0.fk_sender_id == Auth.auth().currentUser?.uid || $0.fk_receiver_id == Auth.auth().currentUser?.uid)})
        
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
            
            let payment = paymentViewModel.payments[indexPath.row]
            if (payment.fk_sender_id == Auth.auth().currentUser?.uid) {
                // Text for: You are sending
                cell.userName.text = "You owe \(payment.first_name_receiver) $\(payment.amount)"
            } else if (payment.fk_receiver_id == Auth.auth().currentUser?.uid) {
                // Text for: You are receiving
                cell.userName.text = "\(payment.first_name_sender) owes you $\(payment.amount)"
            } else {
                // Text for: You are not involved
                cell.userName.text = "\(payment.first_name_sender) owes \(payment.first_name_receiver) $\(payment.amount)"
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
            let activity = paymentViewModel.activity[indexPath.row]
            
            if (activity.fk_sender_id == Auth.auth().currentUser?.uid) {
                // Text for: You sent
                cell.userName.text = "You paid \(activity.first_name_receiver) $\(activity.amount)"
            } else if (activity.fk_receiver_id == Auth.auth().currentUser?.uid) {
                // Text for: You received
                cell.userName.text = "\(activity.first_name_sender) paid you $\(activity.amount)"
            } else {
                // Text for: You are not involved
                cell.userName.text = "\(activity.first_name_sender) paid \(activity.first_name_receiver) $\(activity.amount)"
            }
            
            return cell
        }
    }
}
