//
//  PokedexLocalDataSourceImpl.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation
import Combine
import Factory

struct PokedexLocalDataSourceImpl: PokedexLocalDataSource {
    
    @Injected(\.dataManager) var dataManager
    
    func getPokemonsFromDB() -> AnyPublisher<[DBPokemonDetails], DBError> {
        return dataManager.queryAll(DBPokemonDetails.self, predicate: nil, sortDescriptor: nil)
        
    }
    
    func getFavouritePokemonsFromDB() async -> Result<[DBFavouritePokemon], DBError> {
        return dataManager.queryAllWithoutPublisher(DBFavouritePokemon.self, predicate: nil, sortDescriptor: nil)
    }
    
    func saveFavouritePokemonToDB(favouritePokemon: DBFavouritePokemon) async -> Result<Void, DBError> {
        return await dataManager.save(object: favouritePokemon)
    }
    
    func updatePokemonsDB(pokemons: [DBPokemonDetails]) async -> Result<Void, DBError> {
        let delete = await dataManager.deleteAll(DBPokemonDetails.self)
        switch delete {
        case .success:
            return await dataManager.saveAll(objects: pokemons)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
