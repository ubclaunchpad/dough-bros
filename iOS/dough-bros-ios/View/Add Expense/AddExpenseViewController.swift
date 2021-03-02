//
//  ViewController.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-07.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    var groupMembers: [User]?
    
    var selectedPeople: Set<User> = []
    
    lazy var owedAmounts: [Double] = Array(repeating: 0, count: groupMembers!.count)
    
    var totalSum: Double = 0 {
        didSet {
            addExpenseView.expenseAmount.text = "$\((totalSum * 100).rounded()/100)"
        }
    }
    
    private var addExpenseView: AddExpenseView {
        return view as! AddExpenseView
    }
    
    override func loadView() {
        super.loadView()
        self.view = AddExpenseView()
        addExpenseView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextFields()
        setupCollectionView()
        setupDoneButton()
    }
    
    //MARK: - Setup -
    
    private func setupCollectionView() {
        addExpenseView.addExpenseCollectionView.dataSource = self
        addExpenseView.addExpenseCollectionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


    }
    
    private func setupDoneButton() {
        addExpenseView.finishedButton.addTarget(self, action: #selector(completedExpense), for: .touchUpInside)
    }
    

    private func setupTextFields() {
        addExpenseView.expenseAmount.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        addExpenseView.expenseAmount.addTarget(self, action: #selector(expenseSet), for: .editingDidEnd)
    }
    
    @objc func completedExpense() {
        //TODO: API Call
        
        dismiss(animated: true, completion: nil)
    }
    @objc func handleKeyboardWillShow(notification: Notification) {
        addExpenseView.addExpenseCollectionView.contentInset.bottom = 300
    }
    @objc func keyboardWillHide() {
        addExpenseView.addExpenseCollectionView.contentInset.bottom = 80
    }
    
    @objc func expenseSet(sender: UITextField) {
        var textFieldText = sender.text
        textFieldText?.removeFirst()
        guard let text = textFieldText, let intValue = Double(text), intValue > 0 else {
            totalSum = 0
            owedAmounts = Array(repeating: 0, count: groupMembers!.count)
            addExpenseView.addExpenseCollectionView.reloadData()
            return
        }
        
        totalSum = intValue
        if selectedPeople.count > 0 {
            let eachMemberCost = Double(totalSum)/Double(selectedPeople.count)
            for friend in selectedPeople {
                guard let index = groupMembers!.firstIndex(of: friend) else { continue }
                owedAmounts[index] = eachMemberCost
            }
            addExpenseView.addExpenseCollectionView.reloadData()
        }
    }
    
    @objc func updateTotalExpense(_ sender: UITextField) {
        var textFieldText = sender.text
        textFieldText?.removeFirst()
        guard let text = textFieldText, let intValue = Double(text), intValue > 0 else {
            owedAmounts[sender.tag] = 0
            sender.text = "$0.0"
            selectedPeople.remove(groupMembers![sender.tag])
            addExpenseView.addExpenseCollectionView.cellForItem(at: IndexPath(item: sender.tag, section: 0))?.contentView.backgroundColor = UIColor(hex: 0xF2F2F2)

            totalSum = owedAmounts.reduce(0.0, +)
            return
        }
        
        selectedPeople.insert(groupMembers![sender.tag])
        addExpenseView.addExpenseCollectionView.cellForItem(at: IndexPath(item: sender.tag, section: 0))?.contentView.backgroundColor = UIColor(hex: 0xf3eac2)

        owedAmounts[sender.tag] = intValue
        
        totalSum = owedAmounts.reduce(0.0, +)
    }
    
    @objc func textFieldDidEdit(sender: UITextField) {
        if let text = sender.text, text.first != "$" {
            sender.text = "$\(text)"
        }
    }
}

extension AddExpenseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard addExpenseView.selectedState == .splitEqually else { return }
        if selectedPeople.contains(groupMembers![indexPath.item]) {
            selectedPeople.remove(groupMembers![indexPath.item])
            (collectionView.cellForItem(at: indexPath)!).contentView.backgroundColor = UIColor(hex: 0xF2F2F2)
            (collectionView.cellForItem(at: indexPath) as! AddExpenseCollectionViewCell).checkbox.image = UIImage(systemName: "checkmark.circle")
            owedAmounts[indexPath.item] = 0
            (collectionView.cellForItem(at: indexPath) as! AddExpenseCollectionViewCell).amountOwed.text = "$0.0"

        } else {
            selectedPeople.insert(groupMembers![indexPath.item])
            (collectionView.cellForItem(at: indexPath)!).contentView.backgroundColor = UIColor(hex: 0xf3eac2)
            (collectionView.cellForItem(at: indexPath) as! AddExpenseCollectionViewCell).checkbox.image = UIImage(systemName: "checkmark.circle.fill")
        }
        expenseSet(sender: addExpenseView.expenseAmount)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupMembers!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let friendsCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddExpenseCollectionViewCell.className, for: indexPath) as! AddExpenseCollectionViewCell
                
        friendsCell.amountOwed.tag = indexPath.item
        friendsCell.amountOwed.text = "$\((owedAmounts[indexPath.item] * 100).rounded()/100)"
        friendsCell.amountOwed.addTarget(self, action: #selector(updateTotalExpense), for: .editingDidEnd)
        
        friendsCell.friend = groupMembers![indexPath.item]
        
        friendsCell.updateCell(for: addExpenseView.selectedState)
        
        friendsCell.amountOwed.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        if selectedPeople.contains(groupMembers![indexPath.item]) {
            friendsCell.contentView.backgroundColor = UIColor(hex: 0xf3eac2)
            friendsCell.checkbox.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            friendsCell.contentView.backgroundColor = UIColor(hex: 0xF2F2F2)
            friendsCell.checkbox.image = UIImage(systemName: "checkmark.circle")
        }
        
        return friendsCell
    }
    
}

extension AddExpenseViewController: AddExpenseViewDelegate {
    func didUpdateSelectedState(to: AddExpenseView.SelectedState) {
        selectedPeople.removeAll()
        owedAmounts = Array(repeating: 0, count: groupMembers!.count)
        totalSum = 0
        addExpenseView.addExpenseCollectionView.reloadData()
    }
    
    
}
