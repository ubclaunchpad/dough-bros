//
//  PayConfirmationViewController.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-27.
//

import UIKit

class PayConfirmationViewController: UIViewController {
    
    var debtList: [Any]?
    var paymentObj: PaymentObj?
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
        if (isOwner!) {
            payConfirmationView.descriptionLabel.text = (paymentObj?.first_name ?? "A Friend") + " paid you"
            payConfirmationView.debtAmount.text = "$" + (String(paymentObj?.amount ?? 0))
        } else {
            payConfirmationView.descriptionLabel.text = "You paid"
            payConfirmationView.debtAmount.text = "$" + (String(paymentObj?.amount ?? 0))
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
