//
//  Friend+CoreDataProperties.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 10/02/2023.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var user: User
    
//    var wrappedId : UUID{
//        id ?? UUID()
//    }
//
//    var wrappedName : String{
//        name ?? "unknown"
//    }

}

extension Friend : Identifiable {

}
