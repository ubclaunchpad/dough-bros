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
    // group pending payments
    func fetchData(groupID: Int) {  //pending payments
        // SOME NETWORK call
        setState(to: .loading)
        
        payments = PaymentEndpoints.getGroupPendingPayments(groupID: groupID)
        //payments = PaymentEndpoints.getGroupPending(userID: Auth.auth().currentUser!.uid, groupID: groupID)
        setState(to: .idle)
    }
    
    // pending payments to/from user
    func fetchPendingData(groupID: Int) {
        // SOME NETWORK call
        setState(to: .loading)
        
        activity = PaymentEndpoints.getPaymentsToAndFromUserFromGroup(userID: Auth.auth().currentUser!.uid, groupID: groupID)
        setState(to: .idle)
    }
    
    // group settled payments
    func fetchSettledData(groupID: Int) {
        // SOME NETWORK call
        setState(to: .loading)
        
        activity = PaymentEndpoints.getGroupSettledPayments(groupID: groupID)
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
