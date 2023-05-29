//
//  MockDataTest.swift
//  PokedexTests
//
//  Created by Valentina Olariaga on 29/5/23.
//

import Foundation
@testable import Pokedex

class MockDataTest {
    static var mockPokemons = [
        PokemonDetail(abilities: ["ability1", "ability2"], types: ["type1", "type2"], id: 1, name: "Bulbasaur", height: 0.3, weight: 2, species: "specie", image: "image.jpg", imagesCarrousel: ["image1.jpg", "image2.jpg"]),
        PokemonDetail(abilities: ["ability1", "ability2"], types: ["type1", "type2"], id: 2, name: "Venusaur", height: 0.3, weight: 2, species: "specie", image: "image.jpg", imagesCarrousel: ["image1.jpg", "image2.jpg"])
    ]
    
    static var mockPokemonsFavourite = [
        PokemonFavourite(id: 1, name: "Bulbasaur", image: "image.jpg"),
        PokemonFavourite(id: 2, name: "Venusaur", image: "image.jpg")
    ]
    
}
