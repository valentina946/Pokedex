//
//  GetAllLocalPokemonsUseCase.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 22/5/23.
//

import Foundation
import Combine

public class GetAllLocalPokemonsUseCase {
    let pokedexRepository: PokedexRepository

    init(pokedexRepository: PokedexRepository) {
        self.pokedexRepository = pokedexRepository
    }

    func execute(offset: Int, limit: Int) async -> AnyPublisher<[PokemonDetail], DomainError> {
        let localPublisher = pokedexRepository.getAllLocalPokemons()
        let remotePublisher = Future<[PokemonDetail], DomainError> { promise in
            Task {
                let remotePublisher = await self.pokedexRepository.getAllRemotePokemons(offset: offset, limit: limit)
                switch remotePublisher {
                case .success(let pokemon):
                    let updateResult = await self.pokedexRepository.updateLocalPokemonsFromAPI(pokedex: pokemon)
                    if case .failure(let error) = updateResult {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
            .eraseToAnyPublisher()
        return Publishers.Merge(localPublisher, remotePublisher)
            .eraseToAnyPublisher()
    }
}
