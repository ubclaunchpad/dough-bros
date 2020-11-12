//
//  Friend.swift
//  dough-bros-ios
//
//  Created by Alan Yan on 2020-11-02.
//

import Foundation

struct Friend: Codable, Hashable {
    var name: String
    let id = UUID()
}
