//
//  XXX+CoreDataClass.swift
//  CoreDataCodable
//
//  Created by Danjuma Nasiru on 24/02/2023.
//
//

import Foundation
import CoreData

@objc(XXX)
public class XXX: NSManagedObject, Decodable {
    enum CodingKeys : CodingKey{
        case id, name, gender, age
    }
    
    enum DecoderConfigurationError: Error {
      case missingManagedObjectContext
    }
    
    required convenience public init(from decoder: Decoder) throws{
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContect!] as? NSManagedObjectContext else{throw DecoderConfigurationError.missingManagedObjectContext}
        guard let entity = NSEntityDescription.entity(forEntityName: "XXX", in: context) else{throw DecoderConfigurationError.missingManagedObjectContext}
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(String.self, forKey: .age)
        self.gender = try container.decode(String.self, forKey: .gender)
    }
}
