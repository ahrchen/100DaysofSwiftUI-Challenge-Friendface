//
//  CachedUser+CoreDataProperties.swift
//  Friendface
//
//  Created by Raymond Chen on 3/17/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    public var wrappedId: UUID {
            id ?? UUID()
        }
        
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedAge: Int {
        Int(age)
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown Address"
    }
    
    public var wrappedAbout: String {
        about ?? "Unknown About"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date()
    }
    
    public var wrappedTags: [String] {
        tags?.components(separatedBy: ",") ?? []
     }
    
    public var friendsArray: [Friend] {
        let cachedSet = friends as? Set<CachedFriend> ?? []
        var uncachedFriends: [Friend] = []
        for friend in cachedSet {
            uncachedFriends.append(friend.uncachedFriend)
        }
        return uncachedFriends
    }
    
    public var uncachedUser: User {
        return User(id: self.wrappedId,
                    isActive: self.isActive,
                    name: self.wrappedName,
                    age: self.wrappedAge,
                    company: self.wrappedCompany,
                    email: self.wrappedEmail,
                    address: self.wrappedAddress,
                    about: self.wrappedAbout,
                    registered: self.wrappedRegistered,
                    tags: self.wrappedTags,
                    friends: self.friendsArray
        )
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
