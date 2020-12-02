//
//  PaymentViewModel.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-12-01.
//

import Foundation
import Combine
import Firebase

class PaymentViewModel {
    private(set) var previousState: State?
    @Published private(set) var state: State = .idle
    @Published private(set) var payments: [PaymentObj] = []
    @Published private(set) var activity: [PaymentObj] = []
    
    /// The view controller should call this whenever data needs to be fetched from our API
    func fetchData(groupID: Int) {
        // SOME NETWORK call
        setState(to: .loading)
        
        payments = PaymentEndpoints.getPaymentsToUserFromGroup(userID: Auth.auth().currentUser!.uid, groupID: groupID)
        setState(to: .idle)
    }
    
    func fetchSettledData(creatorID: String, groupID: Int) {
        // SOME NETWORK call
        setState(to: .loading)
        
        activity = PaymentEndpoints.getSettledPaymentsToUserFromGroup(userID: creatorID, groupID: groupID)
        setState(to: .idle)
    }
    
    func setState(to newState: State) {
        previousState = state
        state = newState
    }
    
    enum State {
        case idle
        case loading
        case error(error: Error?, errorMessage: String)
    }
}
