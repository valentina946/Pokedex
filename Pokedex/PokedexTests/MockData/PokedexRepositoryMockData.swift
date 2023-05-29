//
//  PokedexRepositoryMockData.swift
//  PokedexTests
//
//  Created by Valentina Olariaga on 29/5/23.
//

import Foundation
import RealmSwift
import Combine

@testable import Pokedex

struct PokedexRepositoryMockData: PokedexRepository {
    
    let testCase: OptionsTestCase
    
    func getAllRemotePokemons(isNextPressed: Bool?) async -> Result<[PokemonDetail], DomainError> {
        switch testCase {
        case .success:
            return .success(MockDataTest.mockPokemons)
        case .noConnectionToServer:
            return .failure(.noConnectionToServer)
        case .localDataNotFound:
            return .failure(.localDataNotFound)
        case .localDataNotUpdated:
            return .failure(.localDataNotUpdated)
        }
    }
    
    func getAllLocalPokemons() -> AnyPublisher<[PokemonDetail], DomainError> {
        switch testCase {
        case .success:
            return Just(MockDataTest.mockPokemons)
                .setFailureType(to: DomainError.self)
                .eraseToAnyPublisher()
        case .noConnectionToServer:
            return Fail(error: .noConnectionToServer)
                .eraseToAnyPublisher()
        case .localDataNotFound:
            return Fail(error: .localDataNotFound)
                .eraseToAnyPublisher()
        case .localDataNotUpdated:
            return Fail(error: .localDataNotUpdated)
                .eraseToAnyPublisher()
        }
    }
    
    
    func updateLocalPokemonsFromAPI(pokedex: [PokemonDetail]) async -> Result<Void, DomainError> {
        switch testCase {
        case .success:
            return .success(())
        case .noConnectionToServer:
            return .failure(.noConnectionToServer)
        case .localDataNotFound:
            return .failure(.localDataNotFound)
        case .localDataNotUpdated:
            return .failure(.localDataNotUpdated)
        }
    }
    
    func getAllLocalFavouritePokemons() async -> Result<[FavouritePokemon], DomainError> {
        switch testCase {
        case .success:
            return .success(MockDataTest.mockPokemonsFavourite)
        case .noConnectionToServer:
            return .failure(.noConnectionToServer)
        case .localDataNotFound:
            return .failure(.localDataNotFound)
        case .localDataNotUpdated:
            return .failure(.localDataNotUpdated)
        }
    }
    
    func saveFavouritePokemon(favouritePokemon: FavouritePokemon) async -> Result<Void, DomainError> {
        switch testCase {
        case .success:
            return .success(MockDataTest.mockPokemonsFavourite.append(favouritePokemon))
        case .noConnectionToServer:
            return .failure(.noConnectionToServer)
        case .localDataNotFound:
            return .failure(.localDataNotFound)
        case .localDataNotUpdated:
            return .failure(.localDataNotUpdated)
        }
    }
    
    
    
    
}

enum OptionsTestCase {
    case success
    case noConnectionToServer
    case localDataNotFound
    case localDataNotUpdated
}
