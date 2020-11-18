//
//  GroupsViewModel.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import Foundation
import Combine

class GroupsViewModel {
    private var allGroups: [Group] = []
    private var searchText: String = "" {
        didSet {
            searchFor(substring: searchText)
        }
    }
    @Published private(set) var groups: [Group] = []
    @Published private(set) var friends: [Friend] = []
    private(set) var previousState: State?
    @Published private(set) var state: State = .idle
    
    /// The view controller should call this whenever data needs to be fetched from our API
    func fetchData() {
        // SOME NETWORK call
        setState(to: .loading)
        
        //simulates a long network call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            allGroups = [Group(name: "Awesome Group", members: [], image: nil, amount: 20, youOwe: true), Group(name: "Launchpad Friends", members: [], amount: 20), Group(name: "group chat awesome sauce", members: [], amount: 30, youOwe: true)]
            searchFor(substring: searchText)
            friends = [Friend(name: "Bob"), Friend(name: "Alan"), Friend(name: "Wren"), Friend(name: "Avery"), Friend(name: "Stephanie"), Friend(name: "Harin"), Friend(name: "Carlos")]
            
            setState(to: .idle)
        }
    }
    
    func setState(to newState: State) {
        previousState = state
        state = newState
    }
    
    func searchFor(substring: String) {
        guard !substring.isEmpty else { groups = allGroups; return }
        groups = groups.filter({$0.name.uppercased().contains(substring.uppercased())})
    }
    
    enum State {
        case idle
        case loading
        case error(error: Error?, errorMessage: String)
    }
}
