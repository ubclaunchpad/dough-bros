//
//  GroupExpenseObj.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2021-01-29.
//

import Foundation

struct GroupExpenseObj: Codable {
    var fk_gorup_id: Int
    var fk_added_by_id: String
    var fk_currency_id: Int
    var expense_name: String
    var is_archived: Int
    var amount: Double
    //commented to bypass errors
    //var user_amounts: [(fk_sender_id: String, amount: Double)] = []
}
