//
//  PPokemonDetails.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 26/5/23.
//

import Foundation

public struct PPokemonDetails: Hashable, Identifiable {
    
    public let id: Int
    let ability: [String]
    let types: [String]
    let name: String
    let heigth: Int
    let weight: Int
    let species: String
    let color: String
    let image: String
    let imagesCarrousel: [String]
    
    init(pokemon: PokemonDetail) {
        self.id = pokemon.id
        self.ability = pokemon.abilities
        self.types = pokemon.types
        self.name = pokemon.name
        self.heigth = pokemon.height
        self.weight = pokemon.weight
        self.species = pokemon.species
        self.color = pokemon.color ?? "0x000000"
        self.image = pokemon.image
        self.imagesCarrousel = pokemon.imagesCarrousel
    }
    
}
