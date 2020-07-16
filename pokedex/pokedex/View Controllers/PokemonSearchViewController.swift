//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Ahava Morse on 7/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var PokemonSearchBar: UISearchBar!
    @IBOutlet weak var PokemonNameLabel: UILabel!
    @IBOutlet weak var PokemonImageView: UIImageView!
    @IBOutlet weak var PokemonIDLabel: UILabel!
    @IBOutlet weak var PokemonTypesLabel: UILabel!
    @IBOutlet weak var PokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    
    var pokemonController: PokemonController? {
        didSet {
            updateViews()
        }
    }
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PokemonSearchBar.delegate = self
        updateViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        
        if let pokemonController = pokemonController {
            pokemonController.searchPokemon(text: search, completion: setPokemon(pokemon:))
            updateViews()
        }
    }
    
    func setPokemon(pokemon: Pokemon?) {
        if let pokemon = pokemon {
            self.pokemon = pokemon
            updateViews()
        }
    }
    
    func updateViews() {
        if let pokemon = pokemon {
            DispatchQueue.main.async {
                self.PokemonNameLabel.text = pokemon.name.capitalized
                self.PokemonNameLabel.isHidden = false
                
                self.PokemonImageView.image = pokemon.spriteImage()
//                self.PokemonImageView.image?.scale = CGFloat(integerLiteral: 2)
                self.PokemonImageView.isHidden = false
                
                self.PokemonIDLabel.text = "ID: \(pokemon.id)"
                self.PokemonIDLabel.isHidden = false
                
                self.PokemonTypesLabel.text = pokemon.typesString()
                self.PokemonTypesLabel.isHidden = false
                
                self.PokemonAbilitiesLabel.text = pokemon.abilitiesString()
                self.PokemonAbilitiesLabel.isHidden = false
                
                self.savePokemonButton.isHidden = false
            }
        } else {
            self.PokemonNameLabel?.isHidden = true
            self.PokemonImageView?.isHidden = true
            self.PokemonIDLabel?.isHidden = true
            self.PokemonTypesLabel?.isHidden = true
            self.PokemonAbilitiesLabel?.isHidden = true
            self.savePokemonButton?.isHidden = true
        }
    }
    
    

    @IBAction func SavePokemon(_ sender: UIButton) {
        if let pokemonController = pokemonController,
            let pokemon = pokemon {
            pokemonController.addPokemon(pokemon: pokemon)
        }
        navigationController?.popViewController(animated: true)
    }
}
