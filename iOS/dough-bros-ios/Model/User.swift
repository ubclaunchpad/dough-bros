//
//  User.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-10.
//

import Foundation

struct User: Codable, Hashable {
    var firebase_uid: String
    var first_name: String
    var last_name: String
    var email_addr: String
    var facebook_id: String
    var is_anon: Int
    var fcm_token: String
}
