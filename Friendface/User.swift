//
//  User.swift
//  Friendface
//
//  Created by Raymond Chen on 3/16/22.
//

import Foundation

public struct User: Codable, Identifiable {
    public var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
    
