//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ahava Morse on 7/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case id
        case name
        case types
        
        enum AbilityKeys: String, CodingKey {
            case ability
            
            enum AbilityNameKeys: String, CodingKey {
                case name
            }
        }
        
        enum TypeKeys: String, CodingKey {
            case type
            
            enum TypeNameKeys: String, CodingKey {
                case name
            }
        }
    }
    
    var name: String
    var id: String
    var abilities: [String]
    var types: [String]
    
    init(name: String, id: String, abilities: [String], types: [String]) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
        
        var abilitiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
        var abilities: [String] = []
        
        while abilitiesContainer.isAtEnd == false {
            let abilityContainer = try abilitiesContainer.nestedContainer(keyedBy: CodingKeys.AbilityKeys.self)
            
            let abilityNameContainer = try abilityContainer.nestedContainer(keyedBy: CodingKeys.AbilityKeys.AbilityNameKeys.self, forKey: .ability)
            
            let abilityName = try abilityNameContainer.decode(String.self, forKey: .name)
            abilities.append(abilityName)
        }
        
        self.abilities = abilities
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        var types: [String] = []
        
        while typesContainer.isAtEnd == false {
            let typeContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypeKeys.self)
            
            let typeNameContainer = try typeContainer.nestedContainer(keyedBy: CodingKeys.TypeKeys.TypeNameKeys.self, forKey: .type)
            
            let typeName = try typeNameContainer.decode(String.self, forKey: .name)
            types.append(typeName)
        }
        
        self.types = types
    }
}
