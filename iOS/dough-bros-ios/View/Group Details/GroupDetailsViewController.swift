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
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupNameField: UITextField!

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
        groupDetailsView.settleDebtButtonMiddle.addTarget(self, action: #selector(settleDebtTapped), for: .touchUpInside)
        
        self.groupMembers = GroupEndpoints.getUsersInGroup(groupID: groupObj!.group_id)
        
        groupNameField.delegate = self
        groupNameField.isHidden = true
        groupName.isUserInteractionEnabled = true
        let aSelector : Selector = "groupNameLabelTapped"
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        groupName.addGestureRecognizer(tapGesture)

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
    
    //edit group name
    private func groupNameLabelTapped() {
            groupName.isHidden = true
            groupNameField.isHidden = false
            groupNameField.text = groupNameLabel.text
        }

    private func textFieldShouldReturn(nameText: UITextField) {
            nameText.resignFirstResponder()
            groupNameField.isHidden = true
            groupName.isHidden = false
            //groupName.text = groupNameField.text
        
        GroupEndpoints.setGroupName(groupID: groupObj?.group_id, groupName: groupNameField.text)
            groupDetailsView.groupDetailsTableView.reloadData()
    }
    
    @objc private func addExpenseTapped() {
        print("add expense tapped")
        let addExpenseVC = AddExpenseViewController()
        addExpenseVC.groupMembers = self.groupMembers
        present(addExpenseVC, animated: true)
    }
    
    @objc private func settleDebtTapped() {
        let settleDebtVC = SettleDebtViewController()
        settleDebtVC.groupObj = groupObj
        settleDebtVC.isOwner = isOwner
        
        if (isOwner) {
            settleDebtVC.debtList = paymentViewModel.payments.filter({$0.is_settled == 0})
        } else {
            settleDebtVC.debtList = paymentViewModel.payments.filter({$0.is_settled == 0 && $0.fk_sender_id == Auth.auth().currentUser?.uid})
        }
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
            if (paymentViewModel.payments[indexPath.row].is_settled == 1) {
                cell.userName.textColor = UIColor.gray
                if (isOwner || paymentViewModel.payments[indexPath.row].fk_sender_id != Auth.auth().currentUser?.uid) {
                    cell.userName.text = paymentViewModel.payments[indexPath.row].first_name + " is all settled"
                } else {
                    cell.userName.text = "You're all settled!"
                }
            } else {
                if (isOwner) {
                    cell.userName.text = paymentViewModel.payments[indexPath.row].first_name + " owes you $" + String(paymentViewModel.payments[indexPath.row].amount)
                } else if (paymentViewModel.payments[indexPath.row].fk_sender_id != Auth.auth().currentUser?.uid) {
                    // TODO Replace with creator name
                    cell.userName.text = paymentViewModel.payments[indexPath.row].first_name + " owes $" + String(paymentViewModel.payments[indexPath.row].amount)
                } else {
                    cell.userName.text = "You owe $" + String(paymentViewModel.payments[indexPath.row].amount)
                }
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
            if (isOwner) {
                cell.userName.text = paymentViewModel.activity[indexPath.row].first_name + " paid you $" + String(paymentViewModel.activity[indexPath.row].amount)
            } else if (paymentViewModel.payments[indexPath.row].fk_sender_id != Auth.auth().currentUser?.uid) {
                // TODO Replace with creator name
                cell.userName.text = paymentViewModel.activity[indexPath.row].first_name + " paid $" + String(paymentViewModel.activity[indexPath.row].amount)
            } else {
                cell.userName.text = "You paid $" + String(paymentViewModel.payments[indexPath.row].amount)
            }
            
            return cell
        }
    }
}
