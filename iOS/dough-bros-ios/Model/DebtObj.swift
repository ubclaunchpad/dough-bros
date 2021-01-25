//
//  DebtObj.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-27.
//

import Foundation

struct DebtObj: Codable {
    var group_id: Int
    var username: String
    var user_id: String
    var image_uri: String
    var amount: Double
}
