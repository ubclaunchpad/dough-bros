//
//  AddGroupView.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-21.
//

import UIKit

class AddGroupView: UIView {

    private(set) var backButton: UIButton = {
        let back = UIButton(type: .system)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.contentHorizontalAlignment = .fill
        back.contentVerticalAlignment = .fill
        back.imageView?.contentMode = .scaleAspectFit
        back.setImage(UIImage(systemName: "chevron.left.square.fill"), for: .normal)
        back.tintColor = .black
        return back
    }()
    
    private var addGroupTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Who do you want to share this expense with?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private(set) var searchField: UITextField = {
        let amount = UITextField()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.placeholder = "Search email, or phone number!"
        amount.textColor = .black
        amount.font = UIFont.systemFont(ofSize: 16)
        amount.textAlignment = .left
        return amount
    }()
    
    private(set) var addUserCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumInteritemSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(AddGroupCollectionViewCell.self, forCellWithReuseIdentifier: AddGroupCollectionViewCell.className)
        return collectionView
    }()
    
    private var suggestedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Suggested"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private(set) var addGroupTableView: UITableView = {
        let results = UITableView()
        results.translatesAutoresizingMaskIntoConstraints = false
        results.register(AddGroupTableViewCell.self, forCellReuseIdentifier: AddGroupTableViewCell.className)
        results.rowHeight = 70
        results.estimatedRowHeight = 70
        results.isScrollEnabled = false
        results.separatorColor = .clear
        return results
    }()
    
    private(set) var nextButton: UIButton = {
        let back = UIButton(type: .system)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.contentHorizontalAlignment = .fill
        back.contentVerticalAlignment = .fill
        back.imageView?.contentMode = .scaleAspectFit
        back.setImage(UIImage(systemName: "chevron.right.square.fill"), for: .normal)
        back.tintColor = .black
        return back
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
        
        addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
        ])
        
        addSubview(addGroupTitle)
        NSLayoutConstraint.activate([
            addGroupTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            addGroupTitle.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            addGroupTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            addGroupTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: 30),
        ])
        
        addSubview(searchField)
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            searchField.topAnchor.constraint(equalTo: addGroupTitle.bottomAnchor, constant: 30)
        ])
        
        addSubview(addUserCollectionView)
        NSLayoutConstraint.activate([
            addUserCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addUserCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            addUserCollectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30),
            addUserCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        addSubview(suggestedLabel)
        NSLayoutConstraint.activate([
            suggestedLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            suggestedLabel.topAnchor.constraint(equalTo: addUserCollectionView.bottomAnchor, constant: 30),
            suggestedLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            suggestedLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 30),
        ])
        
        addSubview(addGroupTableView)
        NSLayoutConstraint.activate([
            addGroupTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addGroupTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            addGroupTableView.topAnchor.constraint(equalTo: suggestedLabel.bottomAnchor, constant: 10),
            addGroupTableView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: addGroupTableView.bottomAnchor, constant: 30),
            nextButton.widthAnchor.constraint(equalToConstant: 30),
            nextButton.heightAnchor.constraint(equalToConstant: 30),
            nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lowerKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }

    @objc func lowerKeyboard() {
        endEditing(true)
    }
    
}
