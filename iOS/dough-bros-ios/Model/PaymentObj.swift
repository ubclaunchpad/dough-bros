//
//  PaymentObj.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-12-01.
//

import Foundation

struct PaymentObj: Codable {
    var payment_id: Int
    var fk_sender_id: String
    var fk_receiver_id: String
    var fk_creator_id: String
    var fk_parent_expense_id: Int
    var fk_currency_id: Int
    var is_paid: Int
    var is_settled: Int
    var amount: Double
    var first_name: String
    var last_name: String
}
