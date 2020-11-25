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
    
    private var selectPeopleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Or select people:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private(set) var expenseAmount: UITextField = {
        let amount = UITextField()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.keyboardType = .decimalPad
        amount.placeholder = "Insert expense!"
        amount.textColor = .black
        amount.font = UIFont.systemFont(ofSize: 16)
        amount.textAlignment = .left
        return amount
    }()
    
    private(set) var weightSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.minimumTrackTintColor = UIColor(hex: 0xf5b461)
        return slider
    }()
    
    private(set) var weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: 0xf5b461)
        label.text = "50"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
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
        amount.numberOfLines = 0
        return amount
    }()
    
    private(set) var addExpenseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumInteritemSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(AddExpenseCollectionViewCell.self, forCellWithReuseIdentifier: AddExpenseCollectionViewCell.className)
        return collectionView
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
            addExpenseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100)
        ])
        
        addSubview(expenseAmount)
        NSLayoutConstraint.activate([
            expenseAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            expenseAmount.topAnchor.constraint(equalTo: addExpenseLabel.bottomAnchor, constant: 30)
        ])
        
        addSubview(amountOwed)
        NSLayoutConstraint.activate([
            amountOwed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            amountOwed.topAnchor.constraint(equalTo: expenseAmount.bottomAnchor, constant: 30)
        ])
        
        addSubview(selectPeopleLabel)
        NSLayoutConstraint.activate([
            selectPeopleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            selectPeopleLabel.topAnchor.constraint(equalTo: amountOwed.bottomAnchor, constant: 30)
        ])
        
        addSubview(addExpenseCollectionView)
        NSLayoutConstraint.activate([
            addExpenseCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addExpenseCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            addExpenseCollectionView.topAnchor.constraint(equalTo: selectPeopleLabel.bottomAnchor, constant: 30),
            addExpenseCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
//        addSubview(numberPeople)
//        NSLayoutConstraint.activate([
//            numberPeople.centerXAnchor.constraint(equalTo: centerXAnchor),
//            numberPeople.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30)
//        ])
        
        addSubview(weightSlider)
        NSLayoutConstraint.activate([
            weightSlider.centerXAnchor.constraint(equalTo: centerXAnchor),
            weightSlider.topAnchor.constraint(equalTo: addExpenseCollectionView.bottomAnchor, constant: 20),
            weightSlider.widthAnchor.constraint(equalToConstant: 300),
            weightSlider.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        addSubview(weightLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lowerKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }

    @objc func lowerKeyboard() {
        endEditing(true)
    }
    
}
