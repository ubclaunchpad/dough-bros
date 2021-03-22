//
//  GroupsViewModel.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import Foundation
import Combine
import Firebase

class GroupsViewModel {
//    private var allGroups: [GroupObj] = []
    private var searchText: String = "" {
        didSet {
            searchFor(substring: searchText)
        }
    }
    @Published private(set) var groups: [GroupObj] = []
    // This changed from Friend into GroubObj
    @Published private(set) var friends: [GroupObj] = []
    private(set) var previousState: State?
    @Published private(set) var state: State = .idle
    
    /// The view controller should call this whenever data needs to be fetched from our API
    func fetchData() {
        // SOME NETWORK call
        setState(to: .loading)
        
        groups = GroupEndpoints.getGroups(userID: Auth.auth().currentUser!.uid)
        friends = GroupEndpoints.getPendingGroups(userID: Auth.auth().currentUser!.uid)
        
        setState(to: .idle)
    }
    
    public func deleteFromGroups(index: Int) {
        groups.remove(at: index)
    }
    
    public func deleteFromFriends(index: Int) {
        friends.remove(at: index)
    }
    
    func setState(to newState: State) {
        previousState = state
        state = newState
    }
    
    func searchFor(substring: String) {
        guard !substring.isEmpty else { return }
        groups = groups.filter({$0.group_name.uppercased().contains(substring.uppercased())})
    }
    
    enum State {
        case idle
        case loading
        case error(error: Error?, errorMessage: String)
    }
}
