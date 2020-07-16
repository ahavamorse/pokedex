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
    var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func addPokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
    }
    
    func removePokemon(atIndex index: Int) {
        savedPokemon.remove(at: index)
    }
    
    func searchPokemon(text: String, completion: @escaping (Pokemon?) -> ()) {
        let getPokemonUrl = baseURL.appendingPathComponent("\(text.lowercased())")
        
        var returnPokemon: Pokemon?
        
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
}
