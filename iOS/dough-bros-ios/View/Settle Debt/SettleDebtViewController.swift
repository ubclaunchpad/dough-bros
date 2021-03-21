//
//  SettleDebtViewController.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-27.
//

import UIKit
import Firebase
import Combine

//public var summaryStuff = ["Alex owes you $100", "Bob owes you $300", "Charlie has settled his payment", "Daniel owes you $4000"]

protocol PayConfirmationDelegate {
    func dismissPayConfirmation()
    func finishPayConfirmation()
}

class SettleDebtViewController: UIViewController {

    var groupObj:GroupObj?
    var debtList:[PaymentBothNamesObj]?
    var isOwner:Bool?
//    var showPayConfirmation: Bool = false
    
    private var settleDebtView: SettleDebtView {
        return view as! SettleDebtView
    }
    
    // MARK: - View Life Cycle -
    override func loadView() {
        super.loadView()
        view = SettleDebtView()
        settleDebtView.summaryView.dataSource = self
        settleDebtView.summaryView.delegate = self
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
//        if (groupObj != nil && groupObj?.image_uri != "") {
//            let url = URL(string: groupObj!.image_uri)
//            let data = try? Data(contentsOf: url!)
//            settleDebtView.groupImage.image = UIImage(data: data!)
//        }
        settleDebtView.groupName.text = groupObj?.group_name == "" ? "Untitled Group" : groupObj?.group_name
        settleDebtView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
//        if showPayConfirmation {
//            let payConfirmation = PayConfirmationViewController()
//            payConfirmation.payConfirmationDelegate = self
//            showPayConfirmation = false
//
//            print("presenting pay confirmation")
//            self.present(payConfirmation, animated: true)
//        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}

extension SettleDebtViewController: UITableViewDelegate, UITableViewDataSource {
    // Setup Tableview for Either Summary or Activity
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debtList?.count ?? 0
    }
    
    // Setup Tableview cells for either summary or activity
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! SummaryTableViewCell
        cell.selectionStyle = .none
        
        guard let debt = debtList?[indexPath.row] else { return cell }
        
        if (debt.fk_sender_id == Auth.auth().currentUser?.uid) {
            cell.userName.text = "You owe \(debt.first_name_receiver) $\(debt.amount)"
        } else if (debt.fk_receiver_id == Auth.auth().currentUser?.uid) {
            cell.userName.text = "\(debt.first_name_sender) owes you $\(debt.amount)"
        } else {
            // should not get here, but just in case
            cell.userName.text = "\(debt.first_name_sender) owes \(debt.first_name_receiver) $\(debt.amount)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let payConfirmVC = PayConfirmationViewController()
        //TODO: Pass the group through so group details can create the correct views
        payConfirmVC.paymentObj = debtList?[indexPath.row]
        payConfirmVC.isOwner = isOwner
        
        payConfirmVC.payConfirmationDelegate = self
        self.present(payConfirmVC, animated: true)
    }
}

extension SettleDebtViewController: PayConfirmationDelegate {
    func dismissPayConfirmation() {
        self.dismiss(animated: true, completion: nil)
    }
    func finishPayConfirmation() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
