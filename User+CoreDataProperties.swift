//
//  User+CoreDataProperties.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 10/02/2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var company: String?
    @NSManaged public var age: Int16
    @NSManaged public var registered: Date?
    @NSManaged public var email: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    
    var wrappedName:String{
        name ?? "unknown"
    }

    var wrappedAbout: String{
        about ?? "no info"
    }

    var wrappedCompany:String{
        company ?? "Unemployed"
    }

    var wrappedEmail: String{
        email ?? "no email"
    }

    var wrappedAddress: String{
        address ?? "homeless"
    }

    var wrappedRegistered: String{
        registered?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }

    var wrappedId : UUID{
        id ?? UUID()
    }

    var wrappedTags : String{
        tags ?? "no tags"
    }

    var wrappedFriends : [Friend]{
        let set = friends as? Set<Friend> ?? []
        return set.sorted{
            $0.name < $1.name
        }
    }

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension User : Identifiable {

}
