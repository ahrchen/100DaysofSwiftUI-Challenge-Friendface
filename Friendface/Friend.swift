//
//  Friend.swift
//  Friendface
//
//  Created by Raymond Chen on 3/16/22.
//

import Foundation

public struct Friend: Codable, Identifiable {
    public var id: UUID
    var name: String
}
