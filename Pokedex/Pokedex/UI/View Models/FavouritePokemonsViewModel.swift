//
//  FavouritePokemonsViewModel.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 28/5/23.
//

import Foundation
import Factory
import SwiftUI

class FavouritePokemonsViewModel: ObservableObject {
    
    @Injected(\.getAllLocalFavouritePokemonsUseCase) var getAllLocalFavouritePokemonsUseCase
    @Injected(\.saveFavouritePokemonUseCase) var saveFavouritePokemonUseCase
    
    @Published public var saveFavouritePokemonStatus = SavePokemonFavouriteStatus()
    @Published public var getFavouritesPokemonStatus = GetFavouritePokemonStatus()
    
    func getAllFavouritePokemons() async {
        Task {
            await MainActor.run {
                self.getFavouritesPokemonStatus.toLoading()
            }
        }
        
        let getAllLocalFavouritePokemonsUseCase = await self.getAllLocalFavouritePokemonsUseCase.execute()
        switch getAllLocalFavouritePokemonsUseCase {
        case .success(let success):
            await MainActor.run {
                self.getFavouritesPokemonStatus.updateState(pokedex: success.map {PPokemonFavourite(pokemon: $0)})
            }
        case .failure(let failure):
            await MainActor.run {
                self.getFavouritesPokemonStatus.updateState(error: failure)
            }
        }
    }
    
    func saveFavouritePokemon(pokemon: FavouritePokemon) async {
        let saveFavouritePokemonUseCase = await self.saveFavouritePokemonUseCase.execute(pokemon: pokemon)
        switch saveFavouritePokemonUseCase {
        case .success:
            await MainActor.run {
                self.saveFavouritePokemonStatus.updateStateToSuccess()
            }
        case .failure(let failure):
            await MainActor.run {
                self.saveFavouritePokemonStatus.updateState(error: failure)
            }
        }
    }
    
}
