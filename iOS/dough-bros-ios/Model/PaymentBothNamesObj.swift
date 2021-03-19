//
//  PaymentBothNamesObj.swift
//  dough-bros-ios
//
//  Created by Wren Liang on 2021-03-16.
//

import Foundation

struct PaymentBothNamesObj: Codable {
    var payment_id: Int
    var fk_sender_id: String
    var fk_receiver_id: String
    var fk_creator_id: String
    var fk_parent_expense_id: Int
    var fk_currency_id: Int
    var is_paid: Int
    var is_settled: Int
    var amount: Double
    var first_name_sender: String
    var last_name_sender: String
    var first_name_receiver: String
    var last_name_receiver: String
}
