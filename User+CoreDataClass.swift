//
//  User+CoreDataClass.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 10/02/2023.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {

    enum CodingKeys : CodingKey{
        case id, name, address, about, age, company, email, registered, friends, isActive, tags
    }
    
    enum DecoderConfigurationError: Error {
      case missingManagedObjectContext
    }
    
    required convenience public init(from decoder: Decoder) throws{
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContect!] as? NSManagedObjectContext else{
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else{
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decode(String.self, forKey: .address)
        self.email = try container.decode(String.self, forKey: .email)
        self.about = try container.decode(String.self, forKey: .about)
        self.company = try container.decode(String.self, forKey: .company)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.registered = try container.decode(Date.self, forKey: .registered)
        let tagArray = try container.decode([String].self, forKey: .tags)
        self.tags = tagArray.joined(separator: ", ")
        let friendArray = try container.decode([Friend].self, forKey: .friends)
        self.friends = NSSet(array: friendArray)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id.self, forKey: .id)
        try container.encode(name.self, forKey: .name)
        try container.encode(email.self, forKey: .email)
        try container.encode(address.self, forKey: .address)
        try container.encode(about.self, forKey: .about)
        try container.encode(company.self, forKey: .company)
        try container.encode(age.self, forKey: .age)
        try container.encode(isActive.self, forKey: .isActive)
        try container.encode(registered.self, forKey: .registered)
        try container.encode(tags.self, forKey: .tags)
        try container.encode(friends as! Set<Friend>, forKey: .friends)
    }
    
}
