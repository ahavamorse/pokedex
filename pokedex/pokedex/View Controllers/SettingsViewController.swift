//
//  SettingsViewController.swift
//  Pokedex
//
//  Created by Ahava Morse on 7/21/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var sortingMethodSwitch: UISwitch!
    
    var pokemonController: PokemonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func switchSortingMethod(_ sender: UISwitch) {
        if let pokemonController = pokemonController {
            if sender.isOn == true {
                pokemonController.sortMethod = .id
            } else {
                pokemonController.sortMethod = .name
            }
        }
    }
    
    func updateViews() {
        if let pokemonController = pokemonController {
            if pokemonController.sortMethod == .name {
                sortingMethodSwitch.isOn = false
            } else {
                sortingMethodSwitch.isOn = true
            }
        }
    }
}
