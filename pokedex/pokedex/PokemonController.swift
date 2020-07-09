//
//  PokemonController.swift
//  pokedex
//
//  Created by Ahava Morse on 7/9/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import Foundation

class PokemonController {
    
    var savedPokemon: [Pokemon] = []
    
    func addPokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
    }
    
}
