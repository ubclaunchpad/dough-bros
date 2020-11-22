//
//  GroupObj.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-21.
//

import Foundation

struct GroupObj: Codable {
    var group_id: Int
    var group_name: String
    var creator_id: String
    var imageURI: String
    var amount: Double
}
