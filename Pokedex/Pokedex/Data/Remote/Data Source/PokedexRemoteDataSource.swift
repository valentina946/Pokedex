//
//  PokedexRemoteDataSource.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation

protocol PokedexRemoteDataSource {

    func getAllPokemons(isNextPress: Bool?) async -> Result<[PokemonDetail], APIError>

}
