//
//  Friend+CoreDataClass.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 10/02/2023.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Codable {
    
    enum CodingKeys : CodingKey{
        case id, name, user
    }
    
    enum DecoderConfigurationError: Error {
        case missingManagedObjectContext
    }
    
    required convenience public init(from decoder: Decoder) throws{
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContect!] as? NSManagedObjectContext else{
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context)else{
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.user = try container.decode(User.self, forKey: .user)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(user, forKey: .user)
    }
}
