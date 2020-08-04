//
//  PokemonViewController.swift
//  PokeDexLecture
//
//  Created by Ian Becker on 8/4/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLable: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeSearchBar.delegate = self
    }
    
    // MARK: - Private Methods
    private func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
        PokemonController.fetchSprite(for: pokemon) { [weak self] (result) in
            
            DispatchQueue.main.async {
            switch result {
            case .success(let sprite):
                self?.pokeImageView.image = sprite
                self?.pokeNameLable.text = pokemon.name
                self?.pokeIDLabel.text = String(pokemon.id)
            
            case .failure(let error):
                self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        PokemonController.fetchPokemon(searchTerm: searchTerm) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self?.fetchSpriteAndUpdateViews(for: pokemon)
                case.failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
