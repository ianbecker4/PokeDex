//
//  PokemonController.swift
//  PokeDexLecture
//
//  Created by Ian Becker on 8/4/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation
import class UIKit.UIImage

class PokemonController {
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        // Step 1 - URL
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {return completion(.failure(.invalidURL))}
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        print(pokemonURL)
        // Step 2 - Data Task
        URLSession.shared.dataTask(with: pokemonURL) {data, _, error in
            // Step 3 - Handle Error
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            // Step 4 - Check for data
            guard let data = data else {return completion(.failure(.noData))}
            // Step 5 - Decode data
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            // Step 6 - RESUME!!!
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        // Step 1 - URL
        let url = pokemon.sprites.classic
        // Step 2 - Data Task
        URLSession.shared.dataTask(with: url) {data, _, error in
            // Step 3 - Handle Error
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            // Step 4 - Check for data
            guard let spriteData = data else {return completion(.failure(.noData))}
            // Step 5 - Decode Image
            guard let pokemonSprite = UIImage(data: spriteData) else {return completion(.failure(.unableToDecode))}
            return completion(.success(pokemonSprite))
            // Step 6 - RESUME!!!
        }.resume()
    }
} // End of class
