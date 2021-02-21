//
//  GroupsViewController.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-10-25.
//

import UIKit
import Combine

final class GroupsViewController: UIViewController {
    
    private var groupsViewModel = GroupsViewModel()
    private var cancellableSet: Set<AnyCancellable> = []
    
    var selectedGroup: GroupObj = GroupObj(group_id: 1, group_name: "", creator_id: "", image_uri: "", amount: 0.0)
    
    private var groupsView: GroupsView {
        return view as! GroupsView
    }
    
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
    }
    
    // MARK: - Setup -
    private func setupTableView() {
        groupsView.groupsTableView.dataSource = self
        groupsView.groupsTableView.delegate = self
    }
    
    private func setupCollectionView() {
        groupsView.friendsCollectionView.dataSource = self
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
        self.selectedGroup = groupsViewModel.groups[indexPath.row]
        performSegue(withIdentifier: "selectedGroup", sender: self)
        
//        detailedGroupsVC.groupObj = groupsViewModel.groups[indexPath.row]
        navigationController?.pushViewController(detailedGroupsVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GroupDetailsViewController
        vc.groupObj = self.selectedGroup
    }
}

extension GroupsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupsViewModel.friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let friendsCell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupsCollectionViewCell.className, for: indexPath) as! GroupsCollectionViewCell
        
        friendsCell.friend = groupsViewModel.friends[indexPath.item]
        
        return friendsCell
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
