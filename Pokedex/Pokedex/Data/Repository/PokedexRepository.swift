//
//  PokedexRepository.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation
import Combine

protocol PokedexRepository {
    
    func getAllRemotePokemons(isNextPressed: Bool?) async -> Result<[PokemonDetail], DomainError>
    func getAllLocalPokemons() -> AnyPublisher<[PokemonDetail], DomainError>
    func updateLocalPokemonsFromAPI(pokedex: [PokemonDetail]) async -> Result<Void, DomainError>
    func getAllLocalFavouritePokemons() async -> Result<[FavouritePokemon], DomainError>
    func saveFavouritePokemon(favouritePokemon: FavouritePokemon) async -> Result<Void, DomainError>
    
}
