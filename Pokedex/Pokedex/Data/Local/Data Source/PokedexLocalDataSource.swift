//
//  PokedexLocalDataSource.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation
import Combine

protocol PokedexLocalDataSource {
    func getPokemonsFromDB() -> AnyPublisher<[DBPokemonDetails], DBError>
    func updatePokemonsDB(pokemons: [DBPokemonDetails]) async -> Result<Void, DBError>
}
