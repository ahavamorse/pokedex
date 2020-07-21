//
//  PokemonController.swift
//  Pokedex
//
//  Created by Ahava Morse on 7/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

class PokemonController {
    
    var savedPokemon: [Pokemon] = []
    
    var sortMethod: SortMethod = .id
    var sortedPokemon: [Pokemon] {
        get {
            var unsortedList = savedPokemon
            var sortedList: [Pokemon] = []
            
            if sortMethod == .id {
                while unsortedList.count > 0 {
                    var lowestId = unsortedList[0].id
                    var lowestIdIndex = 0
                    
                    for i in 0...unsortedList.count - 1 {
                        if unsortedList[i].id < lowestId {
                            lowestId = unsortedList[i].id
                            lowestIdIndex = i
                        }
                    }
                    sortedList.append(unsortedList[lowestIdIndex])
                    unsortedList.remove(at: lowestIdIndex)
                }
            } else {
                while unsortedList.count > 0 {
                    var nextName = unsortedList[0].name
                    var nextNameIndex = 0
                    
                    for i in 0...unsortedList.count - 1 {
                        if unsortedList[i].name < nextName {
                            nextName = unsortedList[i].name
                            nextNameIndex = i
                        }
                    }
                    sortedList.append(unsortedList[nextNameIndex])
                    unsortedList.remove(at: nextNameIndex)
                }
            }
            return sortedList
        }
    }
    var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var savedPokemonURL: URL? {
        
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let savedPokemonURL = documentsDir?.appendingPathComponent("SavedPokemonList.plist")
        
        return savedPokemonURL
    }
    
    enum SortMethod {
        case id
        case name
    }
    
    func addPokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
        saveToPersistentStore()
    }
    
    func removePokemon(atIndex index: Int) {
        savedPokemon.remove(at: index)
        saveToPersistentStore()
    }
    
    func searchPokemon(text: String, completion: @escaping (Pokemon?) -> ()) {
        let getPokemonUrl = baseURL.appendingPathComponent("\(text.lowercased())")
        
        var request = URLRequest(url: getPokemonUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving pokemon data: \(error)")
                completion(nil)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Error status code: \(response.statusCode)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                NSLog("Bad data")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(pokemon)
            } catch {
                NSLog("Error decoding pokemon objects: \(error)")
                completion(nil)
                return
            }
        }.resume()
    }
    
    func saveToPersistentStore() {
            do {
                
                let encoder = PropertyListEncoder()
                let pokemonData = try encoder.encode(savedPokemon)
                guard let savedPokemonURL = savedPokemonURL else { return }
                try pokemonData.write(to: savedPokemonURL)
                
                print("saved")
            } catch {
                print("Couldn't save list: \(error)")
            }
        }
        
        func loadFromPersistentStore() {
            do {
                guard let savedPokemonURL = savedPokemonURL else { return }
                
                let pokemonPlist = try Data(contentsOf: savedPokemonURL)
                let decoder = PropertyListDecoder()
                let decodedPokemon = try decoder.decode([Pokemon].self, from: pokemonPlist)
                self.savedPokemon = decodedPokemon
                
                print("recovered")
            } catch {
                print("Couldn't load pokemon: \(error)")
            }
        }
}
