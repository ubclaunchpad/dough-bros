//
//  MembersViewController.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2021-03-22.
//

import UIKit
import Firebase
import FirebaseUI
import Combine

class MembersViewController: UIViewController, UITextFieldDelegate {
    
    var groupObj: GroupObj?
    private var groupViewModel = GroupsViewModel()
    private var cancellableSet: Set<AnyCancellable> = []
    private var isOwner = false
    var groupMembers = [User]()
    
    private var membersView: MembersView {
        return view as! MembersView
    }
    
    let storage = Storage.storage()
    
    // MARK: - View Life Cycle -
    deinit {
        cancellableSet.forEach({$0.cancel()})
    }
    override func loadView() {
        super.loadView()
        view = MembersView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.groupMembers = GroupEndpoints.getUsersInGroup(groupID: groupObj!.group_id)
        self.groupMembers.append(contentsOf: UserEndpoints.getUserByID(ID: Auth.auth().currentUser!.uid))

        loadImage()
        membersView.summaryView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        membersView.summaryView.delegate = self
        membersView.summaryView.dataSource = self
                
        if (Auth.auth().currentUser?.uid == groupObj?.creator_id) {
            // Owner
            isOwner = true
        }
        
        setupTextField()
        
        // Get Image
        loadImage()
        
        //        if (groupObj != nil && groupObj?.image_uri != "") {
        //            let url = URL(string: groupObj!.image_uri)
        //            let data = try? Data(contentsOf: url!)
        //            membersView.groupImage.image = UIImage(data: data!)
        //        }
        let groupName = String((groupObj?.group_name.removingPercentEncoding)!)
        
        membersView.groupName.text = groupObj?.group_name == "" ? "Untitled Group" : groupName
        
        membersView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        membersView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        membersView.addExpenseButton.addTarget(self, action: #selector(addExpenseTapped), for: .touchUpInside)
    }
    
    private func loadImage() {
        guard let group = groupObj else {
            return
        }
        
        let storageRef = storage.reference().child("GroupPicture").child(String(group.group_id) + ".jpg")
        membersView.groupImage.sd_setImage(with: storageRef)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        print("edit button presesed")
    }
    
    private func setupTextField() {
        membersView.groupName.delegate = self
        membersView.groupName.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        print("Text changed: " + textField.text!)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: textField)
        perform(#selector(self.reload(_:)), with: textField, afterDelay: 0.75)
    }
    
    @objc func reload(_ textField: UITextField) {
        guard let name = textField.text, name.trimmingCharacters(in: .whitespaces) != "" else {
            print("group name empty")
            return
        }
        print(groupObj!.group_id)
        print("group name: " + name)
        GroupEndpoints.setGroupName(groupID: groupObj!.group_id, groupName: name)
        //membersView.groupName.reloadData()
    }
    
    @objc private func addExpenseTapped() {
        print("add expense tapped")
        let addGroupVC = AddGroupViewController()
        addGroupVC.groupExists = true
        addGroupVC.existingGroupObj = self.groupObj
        navigationController?.pushViewController(addGroupVC, animated: true)
    }
}

extension MembersViewController: UITableViewDataSource, UITableViewDelegate {
    // Setup Tableview for Either Summary or Activity
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupMembers.count
    }
    
    // Setup Tableview cells for either summary or activity
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddGroupTableViewCell.className, for: indexPath) as! AddGroupTableViewCell
            
        cell.userName.text = self.groupMembers[indexPath.row].first_name + " " + self.groupMembers[indexPath.row].last_name
        
        return cell
    }
}

