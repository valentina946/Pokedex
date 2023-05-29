//
//  DBPokemonFavourite.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import Foundation

class DBPokemonFavourite {
    var id: Int
    var name: String
    var image: String
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    init(pokemon: PokemonFavourite) {
        self.id = pokemon.id
        self.name = pokemon.name
        self.image = pokemon.image
    }
    
    public func toDomain() -> PokemonFavourite {
        return PokemonFavourite(id: self.id, name: self.name, image: self.image)
    }
}
