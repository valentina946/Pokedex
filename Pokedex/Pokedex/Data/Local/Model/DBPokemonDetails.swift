//
//  DBPokemonDetails.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 22/5/23.
//

import Foundation
import RealmSwift

class DBPokemonDetails {
    var id: Int
    var abilities: [String]
    var types: [String]
    var name: String
    var height: Double
    var weight: Double
    var species: String
    var color: String?
    var image: String
    var imagesCarrousel: [String]
    
    init(id: Int, abilities: [String], types: [String], name: String, height: Double, weight: Double, species: String, color: String?, image: String, imagesCarrousel: [String]) {
        self.id = id
        self.abilities = abilities
        self.types = types
        self.name = name
        self.height = height
        self.weight = weight
        self.species = species
        self.color = color
        self.image = image
        self.imagesCarrousel = imagesCarrousel
    }
    
    init(pokemon: PokemonDetail) {
        self.id = pokemon.id
        self.abilities = pokemon.abilities
        self.types = pokemon.types
        self.name = pokemon.name
        self.height = pokemon.height
        self.weight = pokemon.weight
        self.species = pokemon.species
        self.color = pokemon.color
        self.image = pokemon.image
        self.imagesCarrousel = pokemon.imagesCarrousel
    }
    
    public func toDomain() -> PokemonDetail {
        return PokemonDetail(abilities: self.abilities, types: self.types, id: self.id, name: self.name, height: self.height, weight: weight, species: species, color: color, image: image, imagesCarrousel: imagesCarrousel)
    }
}
