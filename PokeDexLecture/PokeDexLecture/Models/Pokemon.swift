//
//  Pokemon.swift
//  PokeDexLecture
//
//  Created by Ian Becker on 8/4/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation

// Our model... which is based on the JSON
struct Pokemon: Decodable {
    
    let name: String
    let id: Int
    let sprite: Sprites
    
    struct Sprites: Decodable {
        
        let classic: URL
        
        // CodingKeys allows us to use our own naming conventions
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
        } // End of enum
        
    } // End of struct
    
} // End of struct
