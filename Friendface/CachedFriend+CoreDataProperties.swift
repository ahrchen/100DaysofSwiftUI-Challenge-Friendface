//
//  CachedFriend+CoreDataProperties.swift
//  Friendface
//
//  Created by Raymond Chen on 3/17/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var uncachedFriend: Friend {
        return Friend(id: self.wrappedId, name: self.wrappedName)
    }
}

// MARK: Generated accessors for user
extension CachedFriend {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CachedUser)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CachedUser)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
