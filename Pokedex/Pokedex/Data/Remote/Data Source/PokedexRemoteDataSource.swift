//
//  PokedexRemoteDataSource.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation

protocol PokedexRemoteDataSource {

    func getAllPokemons(offset: Int, limit: Int) async -> Result<[PokemonDetail], APIError>

}
