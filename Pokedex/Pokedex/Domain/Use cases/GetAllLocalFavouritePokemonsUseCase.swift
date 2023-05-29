//
//  GetAllLocalFavouritePokemonsUseCase.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import Foundation
import Combine

public class GetAllLocalFavouritePokemonsUseCase {
    let pokedexRepository: PokedexRepository
    
    init(pokedexRepository: PokedexRepository) {
        self.pokedexRepository = pokedexRepository
    }
    
    func execute() async -> Result<[PokemonFavourite], DomainError> {
        
        return await pokedexRepository.getAllLocalFavouritePokemons()
      
    }
}
