//
//  AddGroupViewController.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-21.
//

import UIKit
import Firebase

class AddGroupViewController: UIViewController, UITextFieldDelegate {
    
    var group = [User]()
    var userResults = [User]()
    
    var selectedPeople: Set<Friend> = []
    
    private var addGroupView: AddGroupView {
        return view as! AddGroupView
    }
    
    override func loadView() {
        super.loadView()
        self.view = AddGroupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        setupTextField()
        addGroupView.backButton.addTarget(self, action: #selector(tappedBack), for: .touchUpInside)
        addGroupView.nextButton.addTarget(self, action: #selector(tappedNext), for: .touchUpInside)

    }
    
    // setup
    private func setupCollectionView() {
        addGroupView.addUserCollectionView.dataSource = self
        addGroupView.addUserCollectionView.delegate = self
    }
    
    private func setupTableView() {
        addGroupView.addGroupTableView.dataSource = self
        addGroupView.addGroupTableView.delegate = self
    }
    
    private func setupTextField() {
        addGroupView.searchField.delegate = self
        addGroupView.searchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        print("Text changed: " + textField.text!)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: textField)
                    perform(#selector(self.reload(_:)), with: textField, afterDelay: 0.75)
    }
            
    @objc func reload(_ textField: UITextField) {
        guard let query = textField.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        
        userResults = UserEndpoints.findUserByPatternMatching(search: query)
        addGroupView.addGroupTableView.reloadData()
    }
    
    @objc private func tappedBack() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappedNext() {
        dismiss(animated: true, completion: nil)
        print("next tapped")
        
        let groupObj = GroupObj(group_id: 0, group_name: "", creator_id: (Auth.auth().currentUser?.uid)!, image_uri: "", amount: 0.0)
        let newGroupID = GroupEndpoints.createGroup(group: groupObj)
        
        for user in group {
            GroupEndpoints.addUserToGroup(user: user, groupID: newGroupID, addedBy: (Auth.auth().currentUser?.uid)!)
        }
        
        let detailedGroupsVC = GroupDetailsViewController()
        /// TODO: fetch GroupObj by newGroupID, and set detailedGroupsVC.groupObc
        
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(detailedGroupsVC, animated: true)
    }


}

extension AddGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        group.remove(at: indexPath.row)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let friendsCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddGroupCollectionViewCell.className, for: indexPath) as! AddGroupCollectionViewCell
        
        friendsCell.user = group[indexPath.row]
        
        return friendsCell
    }
    
}

extension AddGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddGroupTableViewCell.className, for: indexPath) as! AddGroupTableViewCell
        cell.userName.text = userResults[indexPath.row].first_name + " " + userResults[indexPath.row].last_name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        group.append(userResults[indexPath.row])
        addGroupView.addUserCollectionView.reloadData()
    }
}

