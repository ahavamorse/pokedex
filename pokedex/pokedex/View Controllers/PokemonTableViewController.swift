//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Ahava Morse on 7/10/20.
//  Copyright © 2020 Ahava Morse. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    var pokemonController = PokemonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonController.savedPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = pokemonController.savedPokemon[indexPath.row].name

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            pokemonController.removePokemon(atIndex: indexPath.row)
            tableView.reloadData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? PokemonDetailViewController {
            if let index = tableView.indexPathForSelectedRow?.row {
                destination.pokemon = pokemonController.savedPokemon[index]
            }
            
        } else if let destination = segue.destination as? PokemonSearchViewController {
            destination.pokemonController = pokemonController
        }
    }

}
