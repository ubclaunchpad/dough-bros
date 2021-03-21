//
//  PayConfirmationViewController.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-27.
//

import UIKit
import Firebase

class PayConfirmationViewController: UIViewController {
    
    var debtList: [Any]?
    var paymentObj: PaymentBothNamesObj?
    var isOwner: Bool?
    
    var selectedPeople: Set<Friend> = []
    
    private var payConfirmationView: PayConfirmationView {
        return view as! PayConfirmationView
    }
    
    override func loadView() {
        super.loadView()
        self.view = PayConfirmationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Put Debt List Into List
        guard let debt = paymentObj else { return }
        
        if (debt.fk_sender_id == Auth.auth().currentUser?.uid) {
            payConfirmationView.descriptionLabel.text = "You paid \(debt.first_name_receiver)"
            payConfirmationView.debtAmount.text = "$\(debt.amount)"
        } else if (debt.fk_receiver_id == Auth.auth().currentUser?.uid) {
            payConfirmationView.descriptionLabel.text = "\(debt.first_name_sender) paid you"
            payConfirmationView.debtAmount.text = "$\(debt.amount)"
        } else {
            // should not get here, but just in case
            payConfirmationView.descriptionLabel.text = "\(debt.first_name_sender) paid \(debt.first_name_receiver)"
            payConfirmationView.debtAmount.text = "$\(debt.amount)"
        }

        payConfirmationView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        payConfirmationView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextButtonTapped() {
        PaymentEndpoints.settlePayment(paymentID: paymentObj!.payment_id, receiverID: paymentObj!.fk_receiver_id)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
