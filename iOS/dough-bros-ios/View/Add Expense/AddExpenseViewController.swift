//
//  ViewController.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-07.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    var group = Group(name: "snowballs", members: [Friend(name: "Alan"), Friend(name: "Stephanie"), Friend(name: "Charles"), Friend(name: "Serena"), Friend(name: "Daniel"), Friend(name: "Megan"), Friend(name: "Ian"), Friend(name: "Nando"), Friend(name: "Ethan")], image: nil, amount: 5, youOwe: true)
    
    var selectedPeople: Set<Friend> = []
    
    private var addExpenseView: AddExpenseView {
        return view as! AddExpenseView
    }
    
    private var weightSlider: UISlider {
        return addExpenseView.weightSlider as UISlider
    }
    
    private var weightLabel: UILabel {
        return addExpenseView.weightLabel as UILabel
    }
    
    override func loadView() {
        super.loadView()
        self.view = AddExpenseView()
    }
    
    override func viewDidLayoutSubviews() {
        weightLabel.center = alignLabelWithSlider(slider: weightSlider)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupSlider()
        setupExpenseAmountLabels()
    }
    
    // setup
    
    private func setupCollectionView() {
        addExpenseView.addExpenseCollectionView.dataSource = self
        addExpenseView.addExpenseCollectionView.delegate = self
    }
    
    private func setupSlider() {
        UIView.animate(withDuration: 0.7) {
            self.weightSlider.setValue(50, animated: true)
        }
        weightSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    private func setupExpenseAmountLabels() {
        addExpenseView.expenseAmount.addTarget(self, action: #selector(calculateExpense), for: .editingChanged)
        addExpenseView.numberPeople.addTarget(self, action: #selector(calculateExpense), for: .editingChanged)
    }
    
    @objc func calculateExpense() {
        guard let expense = addExpenseView.expenseAmount.text, !expense.isEmpty else {
            addExpenseView.amountOwed.text = ""
            return
        }
        
        addExpenseView.amountOwed.text = "Each person owes $\((Double(expense)! * 100 / Double(group.members.count)).rounded(.up) / 100)"
        
    }
    
    @objc func sliderValueChanged(_ sender: UISlider!) {
        let discreteWeightValue = round(sender.value / 10) * 10
        sender.value = discreteWeightValue
        weightLabel.text = String(discreteWeightValue)
        weightLabel.center = alignLabelWithSlider(slider: sender)
    }
    
    func alignLabelWithSlider(slider: UISlider) -> CGPoint {
        let sliderTrack: CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderFrame: CGRect = slider.thumbRect(forBounds: slider.bounds, trackRect: sliderTrack, value: slider.value)
        return CGPoint(x: sliderFrame.origin.x + slider.frame.origin.x + 10, y: slider.frame.origin.y + 40)
    }

}

extension AddExpenseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedPeople.contains(group.members[indexPath.item]) {
            selectedPeople.remove(group.members[indexPath.item])
            (collectionView.cellForItem(at: indexPath)!).contentView.backgroundColor = UIColor(hex: 0xD8D8D8)
        } else {
            selectedPeople.insert(group.members[indexPath.item])
            (collectionView.cellForItem(at: indexPath)!).contentView.backgroundColor = UIColor(hex: 0xf3eac2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let friendsCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddExpenseCollectionViewCell.className, for: indexPath) as! AddExpenseCollectionViewCell
        
        friendsCell.friend = group.members[indexPath.item]
        
        if selectedPeople.contains(group.members[indexPath.item]) {
            friendsCell.contentView.backgroundColor = UIColor(hex: 0xf3eac2)
        } else {
            friendsCell.contentView.backgroundColor = UIColor(hex: 0xD8D8D8)
        }
        
        return friendsCell
    }
    
}
