//
//  XXX+CoreDataProperties.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 24/02/2023.
//
//

import Foundation
import CoreData


extension XXX {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<XXX> {
        return NSFetchRequest<XXX>(entityName: "XXX")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var age: String
    @NSManaged public var gender: String

}

extension XXX : Identifiable {

}
