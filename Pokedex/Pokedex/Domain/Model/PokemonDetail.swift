//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 25/5/23.
//

import Foundation

struct PokemonDetail: Hashable {
    let abilities: [String]
    let types: [String]
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let species: String
    var color: String?
    let image: String
    let imagesCarrousel: [String]
    
    init(abilities: [String], types: [String], id: Int, name: String, height: Int, weight: Int, species: String, color: String? = nil, image: String, imagesCarrousel: [String]) {
        self.abilities = abilities
        self.types = types
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.species = species
        self.color = color
        self.image = image
        self.imagesCarrousel = imagesCarrousel
    }
    
    init(apiPokemonDetail: APIPokemonDetail) {
        self.abilities = apiPokemonDetail.abilities.map { $0.ability.name }
        self.types = apiPokemonDetail.types.map { $0.type.name }
        self.id = apiPokemonDetail.id
        self.name = apiPokemonDetail.name
        self.height = apiPokemonDetail.height
        self.weight = apiPokemonDetail.weight
        self.species = apiPokemonDetail.species.url
        self.image = apiPokemonDetail.sprites.other.home.frontDefault
        
        let sprites = apiPokemonDetail.sprites
        self.imagesCarrousel = [sprites.backDefault, sprites.backFemale, sprites.backShiny, sprites.backShinyFemale, sprites.frontDefault, sprites.frontFemale, sprites.frontShiny, sprites.frontShinyFemale].compactMap( { $0 })
    }

}
