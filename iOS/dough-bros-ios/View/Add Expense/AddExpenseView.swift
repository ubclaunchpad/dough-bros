//
//  AddExpenseView.swift
//  dough-bros-ios
//
//  Created by Stephanie Chen on 2020-11-07.
//

//MARK: SwiftUI Preview
import SwiftUI
import UIKit
import AlanYanHelpers

class SwiftUIPreviewController: UIViewController {
    override func viewDidLoad() {
        //TODO: REPLACE THIS WITH YOUR VIEW
        self.view = AddExpenseView()
    }
}

protocol AddExpenseViewDelegate: class {
    func didUpdateSelectedState(to: AddExpenseView.SelectedState)
}
class AddExpenseView: UIView {

    private(set) var selectedState: SelectedState = .splitEqually {
        didSet {
            updateSelectedState()
            selectionTypeView.updateSelectedState(to: selectedState)
            if oldValue != selectedState {
                delegate?.didUpdateSelectedState(to: selectedState)
            }
        }
    }
    
    weak var delegate: AddExpenseViewDelegate?
    
    private var addExpenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: 0x2C365A)
        label.text = "Add Expense"
        label.textAlignment = .left
        label.font = UIFont.customFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private var selectPeopleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: 0x2C365A)
        label.text = "Paid by Me"
        label.font = .customFont(ofSize: 14)
        return label
    }()
    
    private var selectionTypeView = AddExpenseDropDownView()
    
    private(set) var expenseAmount: UITextField = {
        let amount = UITextField()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.keyboardType = .decimalPad
        amount.text = "$0.0"
        amount.isEnabled = true
        amount.textColor = UIColor(hex: 0x2C365A)
        amount.font = UIFont.customFont(ofSize: 20, weight: .bold)
        amount.textAlignment = .center
        amount.backgroundColor = UIColor(hex: 0xF2F2F2)
        amount.addDoneButtonOnKeyboard()
        amount.addCorners(30)
        return amount
    }()
    
    private(set) var expenseDescription: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.customFont(ofSize: 14)
        label.placeholder = "Enter a description"
        label.backgroundColor = UIColor(hex: 0xF2F2F2)
        label.addCorners(20)
        label.setLeftPaddingPoints(15)
        label.setRightPaddingPoints(15)
        return label
    }()
    
    private(set) var numberPeople: UITextField = {
        let people = UITextField()
        people.translatesAutoresizingMaskIntoConstraints = false
        people.keyboardType = .numberPad
        people.placeholder = "Insert number of pee pole!"
        people.textColor = .black
        people.font = UIFont.customFont(ofSize: 16)
        people.textAlignment = .center
        return people
    }()
    
    private(set) var addExpenseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 80)
        layout.minimumInteritemSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 80, right: 20)
        collectionView.register(AddExpenseCollectionViewCell.self, forCellWithReuseIdentifier: AddExpenseCollectionViewCell.className)
        return collectionView
    }()
    
    private(set) var finishedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: 0x88CBDB)
        let config  = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "checkmark", withConfiguration: config), for: .normal)
        button.tintColor = .white
        return button
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
            addExpenseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            addExpenseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30)
        ])
        
        addSubview(expenseAmount)
        NSLayoutConstraint.activate([
            expenseAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            expenseAmount.topAnchor.constraint(equalTo: addExpenseLabel.bottomAnchor, constant: 20),
            expenseAmount.heightAnchor.constraint(equalToConstant: 60),
            expenseAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        addSubview(expenseDescription)
        NSLayoutConstraint.activate([
            expenseDescription.topAnchor.constraint(equalTo: expenseAmount.bottomAnchor, constant: 20),
            expenseDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            expenseDescription.heightAnchor.constraint(equalToConstant: 40),
            expenseDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        addSubview(selectPeopleLabel)
        NSLayoutConstraint.activate([
            selectPeopleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectPeopleLabel.topAnchor.constraint(equalTo: expenseDescription.bottomAnchor, constant: 30)
        ])
        
        addSubview(addExpenseCollectionView)
        NSLayoutConstraint.activate([
            addExpenseCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addExpenseCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            addExpenseCollectionView.topAnchor.constraint(equalTo: selectPeopleLabel.bottomAnchor, constant: 55),
            addExpenseCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        selectionTypeView.topButton.addTarget(self, action: #selector(dropDownButtonClicked), for: .touchUpInside)
        selectionTypeView.bottomButton.addTarget(self, action: #selector(dropDownButtonClicked), for: .touchUpInside)
        selectionTypeView.setSuperview(self).addTop(anchor: selectPeopleLabel.bottomAnchor, constant: 10).addLeading(constant: 30).addTrailing(constant: -30)
            .addHeight(withConstant: 40).addCorners(10).setColor(.white)
        
        selectionTypeView.updateSelectedState(to: selectedState)
        
        finishedButton.setSuperview(self).addTrailing(constant: -20).addBottom(constant: -30).addWidth(withConstant: 64).addHeight(withConstant: 64).addCorners(32)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lowerKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }

    private func updateDropDownHeight() {
        selectionTypeView.userDefinedConstraintDict["height"]?.constant = selectionTypeView.viewState == .collapsed ? 40 : 81
        selectionTypeView.bottomButton.userDefinedConstraintDict["height"]?.constant = selectionTypeView.viewState == .collapsed ? 0 : 40
        selectionTypeView.setDropShadow(color: UIColor.black.cgColor, opacity: selectionTypeView.viewState == .collapsed ? 0 : 0.3, offset: CGSize(width: 0, height: 2), radius: 5)
        UIView.animate(withDuration: 0.5) { [self] in
            layoutIfNeeded()
        }
    }
    
    @objc private func dropDownButtonClicked(sender: UIButton) {
        if selectionTypeView.viewState == .collapsed {
            selectionTypeView.viewState = .expanded
        } else {
            selectedState = SelectedState.getType(from: sender.titleLabel!.text!)
            selectionTypeView.viewState = .collapsed
        }
        layoutIfNeeded()
        updateDropDownHeight()
    }
    
    @objc func lowerKeyboard() {
        addExpenseCollectionView.contentInset.bottom = 80
        endEditing(true)
    }
    
    private func updateSelectedState() {
        if selectedState == .splitEqually {
            expenseAmount.isEnabled = true
            expenseAmount.textColor = UIColor(hex: 0x2C365A)
        } else {
            expenseAmount.isEnabled = false
            expenseAmount.textColor = .gray
        }
    }
    enum SelectedState {
        case splitEqually
        case customSplit
        
        func getTitle() -> String {
            switch self {
            case .splitEqually:
                return "Split equally"
            case .customSplit:
                return "Input custom amount"
            }
        }
        
        static func getType(from string: String) -> SelectedState {
            if string == SelectedState.splitEqually.getTitle() {
                return .splitEqually
            } else {
                return .customSplit
            }
        }
    }
}

@available(iOS 13.0, *)
struct ControllerPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        typealias UIViewControllerType = UIViewController
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ControllerPreview.ContainerView>) -> ControllerPreview.ContainerView.UIViewControllerType {
            return AddExpenseViewController()
        }
        
        func updateUIViewController(_ uiViewController: ControllerPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ControllerPreview.ContainerView>) {
            
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIView {
    func setDropShadow(color: CGColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        clipsToBounds = false
      layer.shadowColor = color
      layer.shadowOpacity = opacity
      layer.shadowOffset = offset
      layer.shadowRadius = radius
    }
}
