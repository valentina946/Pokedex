//
//  PokedexRepositoryImpl.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation
import Alamofire
import Factory
import Combine
import RealmSwift

struct PokedexRepositoryImpl: PokedexRepository {
    
    @Injected(\.pokedexRemoteDataSource) var pokedexRemoteDataSource: PokedexRemoteDataSource
    @Injected(\.pokedexLocalDataSource) var pokedexLocalDataSource: PokedexLocalDataSource
    
    func getAllLocalPokemons() -> AnyPublisher<[PokemonDetail], DomainError> {
        return pokedexLocalDataSource.getPokemonsFromDB()
            .map { $0.map { $0.toDomain() } }
            .mapError { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func getAllLocalFavouritePokemons() async -> Result<[PokemonFavourite], DomainError> {
        let pokedexLocalDataSource = await pokedexLocalDataSource.getFavouritePokemonsFromDB()
        switch pokedexLocalDataSource {
        case .success(let success):
            return .success(success.map {$0.toDomain()})
        case .failure(let failure):
            return .failure(failure.toDomain())
        }
        
    }
    
    func saveFavouritePokemon(favouritePokemon: PokemonFavourite) async -> Result<Void, DomainError> {
        return await pokedexLocalDataSource.saveFavouritePokemonToDB(favouritePokemon: DBPokemonFavourite(pokemon: favouritePokemon))
            .mapError { $0.toDomain() }
    }
    
    func getAllRemotePokemons(isNextPressed: Bool?) async -> Result<[PokemonDetail], DomainError> {
        return await pokedexRemoteDataSource.getAllPokemons(isNextPress: isNextPressed)
            .map { $0.map { $0 } }
            .mapError { $0.toDomain() }
    }
    
    func updateLocalPokemonsFromAPI(pokedex: [PokemonDetail]) async -> Result<Void, DomainError> {
        
        return await pokedexLocalDataSource.updatePokemonsDB(pokemons: pokedex.map { DBPokemonDetails(pokemon: $0) })
            .mapError { $0.toDomain() }
    }
    
}
