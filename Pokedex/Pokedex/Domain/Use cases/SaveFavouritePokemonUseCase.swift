//
//  SaveFavouritePokemonUseCase.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import Foundation

public class SaveFavouritePokemonUseCase {
    let pokedexRepository: PokedexRepository
    
    init(pokedexRepository: PokedexRepository) {
        self.pokedexRepository = pokedexRepository
    }
    
    func execute(pokemon: PokemonFavourite) async -> Result<Void, DomainError> {
        return await pokedexRepository.saveFavouritePokemon(favouritePokemon: pokemon)
    }
}
