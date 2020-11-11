//
//  User.swift
//  dough-bros-ios
//
//  Created by Harin Wu on 2020-11-10.
//

import Foundation

public class User {
    
    var firebase_uid: String
    var first_name: String
    var last_name: String
    var email_addr: String
    var facebook_id: String
    var is_anon: Bool
    var fcm_token: String
    
    init(firebase_uid: String, first_name: String, last_name: String, email_addr: String, facebook_id: String, is_anon: Bool, fcm_token: String) {
        self.firebase_uid = firebase_uid
        self.first_name = first_name
        self.last_name = last_name
        self.email_addr = email_addr
        self.facebook_id = facebook_id
        self.is_anon = is_anon
        self.fcm_token = fcm_token
    }
}



// MARK: - Json data
extension User {
    func data() -> [String:Any] {
        return [ "firebase_uid" : firebase_uid,
                 "first_name" : first_name,
                 "last_name" : last_name,
                 "email_addr" : email_addr,
                 "facebook_id" : facebook_id,
                 "is_anon" : is_anon,
                 "fcm_token" : fcm_token]
    }
}
