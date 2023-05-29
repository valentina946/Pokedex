//
//  PokemonFavourite.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import Foundation

struct PokemonFavourite: Hashable {
    let id: Int
    let name: String
    let image: String

    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }

}
