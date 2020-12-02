//
//  SettleDebtViewController.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-27.
//

import UIKit
import Combine

public var summaryStuff = ["Alex owes you $100", "Bob owes you $300", "Charlie has settled his payment", "Daniel owes you $4000"]

class SettleDebtViewController: UIViewController {

    var groupObj:GroupObj?
    var debtList:[PaymentObj]?

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
        cell.userName.text = (debtList?[indexPath.row].first_name ?? "") + " owes you $" + String(debtList?[indexPath.row].amount ?? 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let payConfirmVC = PayConfirmationViewController()
        //TODO: Pass the group through so group details can create the correct views
        payConfirmVC.paymentObj = debtList?[indexPath.row]
        
        navigationController?.pushViewController(payConfirmVC, animated: true)
    }
}
