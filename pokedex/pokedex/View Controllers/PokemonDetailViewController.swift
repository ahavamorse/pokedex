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
            PokemonNameLabel.text = pokemon.name
            PokemonIDLabel.text = "ID: \(pokemon.id)"
            PokemonTypesLabel.text = pokemon.typesString()
            PokemonAbilitiesLabel.text = pokemon.abilitiesString()
            PokemonImageView.image = pokemon.spriteImage()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
