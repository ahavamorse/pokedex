//
//  PokemonSearchViewController.swift
//  Pokedex
//
//  Created by Ahava Morse on 7/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController {

    @IBOutlet weak var PokemonSearchBar: UISearchBar!
    @IBOutlet weak var PokemonNameLabel: UILabel!
    @IBOutlet weak var PokemonImageView: UIImageView!
    @IBOutlet weak var PokemonIDLabel: UILabel!
    @IBOutlet weak var PokemonTypesLabel: UILabel!
    @IBOutlet weak var PokemonAbilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func SavePokemon(_ sender: UIButton) {
        
    }
}
