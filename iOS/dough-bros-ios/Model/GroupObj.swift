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
    var image_uri: String
    var amount: Double
    
//    private init(groupID: Int, groupName: String, creatorID: String, imageURL: String, amount: Double) {
//        group_id = groupID
//        group_name = groupName
//        creator_id = creatorID
//        image_uri = imageURL
//        self.amount = amount
//    }
    static func createMockGroups() -> [GroupObj] {
        return [GroupObj(group_id: 1, group_name: "Sample Group1", creator_id: "1", image_uri: "https://i.pinimg.com/originals/8f/28/46/8f2846eb305bb131775583cb36edf4dc.jpg", amount: 20), GroupObj(group_id: 1, group_name: "Sample Group 2", creator_id: "1", image_uri: "https://i.pinimg.com/originals/8f/28/46/8f2846eb305bb131775583cb36edf4dc.jpg", amount: 60), GroupObj(group_id: 1, group_name: "Sample Group 3", creator_id: "3", image_uri: "https://i.pinimg.com/originals/8f/28/46/8f2846eb305bb131775583cb36edf4dc.jpg", amount: 80)]
    }
}
