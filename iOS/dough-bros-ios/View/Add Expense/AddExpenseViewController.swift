//
//  ViewController.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-07.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    private var addExpenseView: AddExpenseView {
        return view as! AddExpenseView
    }
    
    override func loadView() {
        super.loadView()
        self.view = AddExpenseView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addExpenseView.expenseAmount.addTarget(self, action: #selector(calculateExpense), for: .editingChanged)
        addExpenseView.numberPeople.addTarget(self, action: #selector(calculateExpense), for: .editingChanged)
    }
    
    @objc func calculateExpense() {
        guard let expense = addExpenseView.expenseAmount.text, !expense.isEmpty,
              let numPeople = addExpenseView.numberPeople.text, !numPeople.isEmpty else {
            return
        }
        
        addExpenseView.amountOwed.text = "Each person owes \((Double(expense)! * 100 / Double(numPeople)!).rounded(.up) / 100)"
        
    }
}
