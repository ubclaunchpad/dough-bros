//
//  GroupsView.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit
import AlanYanHelpers

class GroupsView: UIView {
    // MARK: - Subviews -
    private(set) var searchField: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        
        return searchBar
    }()
    
    private var collectionViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent"
        label.textAlignment = .left
        label.font = UIFont.customFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var tableViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Groups"
        label.textAlignment = .left
        label.font = UIFont.customFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private(set) var friendsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumInteritemSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(GroupsCollectionViewCell.self, forCellWithReuseIdentifier: GroupsCollectionViewCell.className)
        return collectionView
    }()
    
    private(set) var groupsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.className)
        return tableView
    }()
    
    private(set) var createGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADD GROUP", for: .normal)
        return button
    }()
    
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

        searchField.setSuperview(self).addLeading().addTrailing().addTopSafe(constant: 20)
        
        collectionViewLabel.setSuperview(self).addLeading(constant: 20).addTop(anchor: searchField.bottomAnchor, constant: 10)
        
        friendsCollectionView.setSuperview(self).addTop(anchor: collectionViewLabel.bottomAnchor, constant: 5).addLeading().addTrailing().addHeight(withConstant: 100)
        
        tableViewLabel.setSuperview(self).addLeading(constant: 20).addTop(anchor: friendsCollectionView.bottomAnchor, constant: 10)

        groupsTableView.setSuperview(self).addTop(anchor: tableViewLabel.bottomAnchor, constant: 10).addLeading(constant: 20).addTrailing(constant: -20).addBottomSafe()
        
        createGroupButton.setSuperview(self).addBottomSafe(constant: -20).addCenterX().addWidth(withConstant: 120).addHeight(withConstant: 40).setColor(.gray).addCorners(10)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.cancelsTouchesInView = false
        tapGesture.addTarget(self, action: #selector(didPressScreen))
        addGestureRecognizer(tapGesture)
    }
    
    
    @objc private func didPressScreen() {
        endEditing(true)
    }
}
