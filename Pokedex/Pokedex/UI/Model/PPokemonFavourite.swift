//
//  PPokemonFavourite.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import Foundation

struct PPokemonFavourite: Hashable {
    
    let id: Int
    let name: String
    let image: String

    init(pokemon: FavouritePokemon) {
        self.id = pokemon.id
        self.name = pokemon.name
        self.image = pokemon.image
    }

}
