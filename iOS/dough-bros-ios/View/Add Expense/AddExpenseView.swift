//
//  AddExpenseView.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-07.
//

import UIKit

class AddExpenseView: UIView {

    private var addExpenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Add Expense"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private(set) var expenseAmount: UITextField = {
        let amount = UITextField()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.keyboardType = .decimalPad
        amount.placeholder = "Insert expense!"
        amount.textColor = .black
        amount.font = UIFont.systemFont(ofSize: 16)
        amount.textAlignment = .center
        return amount
    }()
    
    private(set) var numberPeople: UITextField = {
        let people = UITextField()
        people.translatesAutoresizingMaskIntoConstraints = false
        people.keyboardType = .numberPad
        people.placeholder = "Insert number of pee pole!"
        people.textColor = .black
        people.font = UIFont.systemFont(ofSize: 16)
        people.textAlignment = .center
        return people
    }()
    
    private(set) var amountOwed: UILabel = {
        let amount = UILabel()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.textColor = .black
        amount.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return amount
    }()
    
    // UIPickerView for # of people? or another UITextField
    
    //MARK: - Initializers -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // REQUIRED implementation for loading views from cached storyboards since we implemented another init we need to cover the required inits, we will never use this method though
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    // MARK: - Setup -
    private func setupView() {
        backgroundColor = .white
        
        addSubview(addExpenseLabel)
        NSLayoutConstraint.activate([
            addExpenseLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            addExpenseLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(expenseAmount)
        NSLayoutConstraint.activate([
            expenseAmount.centerXAnchor.constraint(equalTo: centerXAnchor),
            expenseAmount.topAnchor.constraint(equalTo: addExpenseLabel.bottomAnchor, constant: 30)
        ])
        
        addSubview(numberPeople)
        NSLayoutConstraint.activate([
            numberPeople.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberPeople.topAnchor.constraint(equalTo: expenseAmount.bottomAnchor, constant: 30)
        ])
        
        addSubview(amountOwed)
        NSLayoutConstraint.activate([
            amountOwed.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountOwed.topAnchor.constraint(equalTo: numberPeople.bottomAnchor, constant: 30)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lowerKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }

    @objc func lowerKeyboard() {
        endEditing(true)
    }
    
}
