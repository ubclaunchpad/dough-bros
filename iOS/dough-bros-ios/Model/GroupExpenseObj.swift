//
//  GroupExpenseObj.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2021-01-29.
//

import Foundation

struct GroupExpenseObj: Codable, Hashable {
    var expense_id: Int
    var group_id: Int
    var addedBy: String
    var currency_id: Int
    var is_archived: Bool
    var expense_name: String
    var amount: Double
}

struct ParentGroupExpenseObj: Codable {
    var expense_id: Int
    var fk_group_id: Int
    var fk_added_by_id: String
    var fk_currency_id: Int
    var is_archived: Int
    var expense_name: String
    var amount: Double
}
