//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ahava Morse on 7/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case id
        case name
        case types
        case sprites
        
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
        
        enum SpritesKeys: String, CodingKey {
            case front_default
        }
    }
    
    var name: String
    var id: Int
    var abilities: [String]
    var types: [String]
    var spriteImageURL: URL
    
    init(name: String, id: Int, abilities: [String], types: [String], url: URL) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.spriteImageURL = url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        
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
        
        let spritesContainer = try container.nestedContainer(keyedBy: CodingKeys.SpritesKeys.self, forKey: .sprites)
        let urlString = try spritesContainer.decode(String.self, forKey: .front_default)
        
        self.spriteImageURL = URL(string: urlString)!
    }
    
    func typesString() -> String {
        var string = "Types: \(types[0])"
        
        if types.count >= 2 {
            
            for i in 1...(types.count - 1) {
                string += ", \(types[i])"
            }
        }
        return string.capitalized
    }
    
    func abilitiesString() -> String {
        var string = "Abilities: \(abilities[0])"
        
        if abilities.count >= 2 {
            
            for i in 1...(abilities.count - 1) {
                string += ", \(abilities[i])"
            }
        }
        return string.capitalized
    }
    
    func spriteImage() -> UIImage? {
        if let data = try? Data(contentsOf: spriteImageURL) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
}
