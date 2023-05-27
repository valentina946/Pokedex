//
//  APIPokemon.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation

struct APIPokemon: Codable {
    let name: String
    let url: String
    
    func toDomain() -> Pokemon {
        return Pokemon(name: self.name)
    }
}
