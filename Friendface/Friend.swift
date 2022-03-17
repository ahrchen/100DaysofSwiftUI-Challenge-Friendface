//
//  Friend.swift
//  Friendface
//
//  Created by Raymond Chen on 3/16/22.
//

import Foundation

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}
