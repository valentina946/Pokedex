//
//  GetAllPokemonsUseCase.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 23/5/23.
//

import Foundation

public class GetAllRemotePokemonsUseCase {
    let pokedexRepository: PokedexRepository
    
    init(pokedexRepository: PokedexRepository) {
        self.pokedexRepository = pokedexRepository
    }
    
    func execute(isNextPress: Bool) async -> Result<[PokemonDetail], DomainError> {
        return await pokedexRepository.getAllRemotePokemons(isNextPressed: isNextPress)
        
    }
}

