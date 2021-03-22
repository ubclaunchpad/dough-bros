//
//  GroupsViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit
import Combine
import Firebase
import FirebaseUI

protocol CarlosTutorialDelegate {
    func dismissTutorial()
}

final class GroupsViewController: UIViewController {
    
    private var groupsViewModel = GroupsViewModel()
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var groupsView: GroupsView {
        return view as! GroupsView
    }
    
    var showTutorial: Bool = false
    
    let storage = Storage.storage()
    
    // MARK: - View Life Cycle -
    deinit {
        cancellableSet.forEach({$0.cancel()})
    }
    override func loadView() {
        super.loadView()
        
        view = GroupsView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        setupSearchBar()
        setupAddGroupButton()
        setupViewModel()
        
        if showTutorial {
            let tutorial = CarlosViewController()
            tutorial.tutorialDelegate = self
            showTutorial = false
            
            self.present(tutorial, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        groupsViewModel.fetchData()
        groupsView.groupsTableView.reloadData()
        groupsView.friendsCollectionView.reloadData()
    }
    
    // MARK: - Setup -
    private func setupTableView() {
        groupsView.groupsTableView.dataSource = self
        groupsView.groupsTableView.delegate = self
    }
    
    private func setupCollectionView() {
        groupsView.friendsCollectionView.dataSource = self
        groupsView.friendsCollectionView.delegate = self
    }
    
    private func setupSearchBar() {
        groupsView.searchField.delegate = self
    }
    
    private func setupAddGroupButton() {
        groupsView.createGroupButton.addTarget(self, action: #selector(tappedAddGroupButton), for: .touchUpInside)
    }
    
    private func setupViewModel() {
        groupsViewModel.$friends.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.groupsView.friendsCollectionView.reloadData()
        }.store(in: &cancellableSet)
        
        groupsViewModel.$groups.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.groupsView.groupsTableView.reloadData()
        }.store(in: &cancellableSet)
        
        groupsViewModel.$state.receive(on: DispatchQueue.main).sink { [weak self] state in
            //TODO: Handle State, show activity indicator if in loading state, error message if in error state, etc.
        }
        
        groupsViewModel.fetchData()
    }
    
    //MARK: - Actions -
    @objc private func tappedAddGroupButton() {
        print("add group tapped")
        let addGroupVC = AddGroupViewController()
        navigationController?.pushViewController(addGroupVC, animated: true)
    }
}


extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsViewModel.groups.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupsCell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.className) as! GroupTableViewCell
        
        groupsCell.group = groupsViewModel.groups[indexPath.row]
        
        return groupsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedGroupsVC = GroupDetailsViewController()
        //TODO: Pass the group through so group details can create the correct views
        detailedGroupsVC.groupObj = groupsViewModel.groups[indexPath.row]
        navigationController?.pushViewController(detailedGroupsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            groupsViewModel.deleteFromGroups(index: indexPath.row)
            /// TODO: call delete endpoint!
            tableView.reloadData()
        }
    }
}

extension GroupsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupsViewModel.friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let friendsCell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupsCollectionViewCell.className, for: indexPath) as! GroupsCollectionViewCell
        
        friendsCell.friend = groupsViewModel.friends[indexPath.item]
        
        let storageRef = storage.reference().child("GroupPicture").child(String(groupsViewModel.friends[indexPath.item].group_id) + ".jpg")
        friendsCell.profilePictureView.sd_setImage(with: storageRef, placeholderImage: UIImage(systemName: "person.crop.circle.fill"))
        
        return friendsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let groupName = groupsViewModel.groups[indexPath.row].group_name == "" ? "Untitled Group" : groupsViewModel.groups[indexPath.row].group_name
        
        let myAlert = UIAlertController(title: "Group Invitation!", message: "You've been invited to '\(groupName)'", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Decline", style: .destructive, handler: { _ in
            print("cancel")
        })
        let accept = UIAlertAction(title: "Accept", style: .default, handler: { [self] _ in
            GroupEndpoints.acceptGroupMembership(groupID: groupsViewModel.friends[indexPath.row].group_id, userID: Auth.auth().currentUser!.uid)
            groupsViewModel.fetchData()
            groupsView.groupsTableView.reloadData()
            groupsView.friendsCollectionView.reloadData()
        })
        
        myAlert.addAction(accept)
        myAlert.addAction(cancel)
        
        self.present(myAlert, animated: true, completion: nil)
    }
}

extension GroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        groupsViewModel.searchFor(substring: searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension GroupsViewController: CarlosTutorialDelegate {
    func dismissTutorial() {
        self.dismiss(animated: true, completion: nil)
    }
}
