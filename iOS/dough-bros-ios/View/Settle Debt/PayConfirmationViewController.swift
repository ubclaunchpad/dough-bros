//
//  PayConfirmationViewController.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-27.
//

import UIKit

class PayConfirmationViewController: UIViewController {
    
    var debtList: [Any]?
    var name:String?
    var amount:String?
    
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
        payConfirmationView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        payConfirmationView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
