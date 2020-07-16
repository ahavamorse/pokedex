//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ahava Morse on 7/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var PokemonNameLabel: UILabel!
    @IBOutlet weak var PokemonImageView: UIImageView!
    @IBOutlet weak var PokemonIDLabel: UILabel!
    @IBOutlet weak var PokemonTypesLabel: UILabel!
    @IBOutlet weak var PokemonAbilitiesLabel: UILabel!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            PokemonNameLabel.text = pokemon.name.capitalized
            PokemonIDLabel.text = "ID: \(pokemon.id)"
            PokemonTypesLabel.text = pokemon.typesString()
            PokemonAbilitiesLabel.text = pokemon.abilitiesString()
            PokemonImageView.image = pokemon.spriteImage()
        }
    }
}
