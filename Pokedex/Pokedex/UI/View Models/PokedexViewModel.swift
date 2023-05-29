//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation
import Factory
import Combine
import SwiftUI

class PokedexViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    
    @Injected(\.getAllLocalPokemonsUseCase) var getAllLocalPokemonsUseCase
    
    init() {
        Task {
            await self.getAllPokemon(isNextPress: nil)
        }
    }
    
    @Published public var pokemonNamesState = PokedexStatus(status: .initial)
    
    func getAllPokemon(isNextPress: Bool?) async {
     
        Task {
            await MainActor.run {
                withAnimation {
                    self.pokemonNamesState = PokedexStatus(status: .loading)
                }
            }
        }
        
        await getAllLocalPokemonsUseCase.execute(isNextPressed: isNextPress)
            .map { $0.map { PPokemonDetails(pokemon: $0) } }
            .receive(on: DispatchQueue.main)
            
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        Task {
                            await MainActor.run {
                                withAnimation(.default.speed(2)) {
                                    self.pokemonNamesState = PokedexStatus(status: .noContentError, error: error)
                                }
                            }
                        }
                    } else if self.pokemonNamesState.status == .loading || self.pokemonNamesState.status == .initial {
                        Task {
                            await MainActor.run {
                                withAnimation(.default.speed(2)) {
                                    self.pokemonNamesState = PokedexStatus(status: .outdatedContentError)
                                }
                            }
                        }
                    }
                },
                receiveValue: { values in
                    Task {
                        await MainActor.run {
                            withAnimation {
                                self.pokemonNamesState = PokedexStatus(status: .success, pokedex: values)
                            }
                        }
                    }
            })
            .store(in: &cancellable)
    }
    
}
