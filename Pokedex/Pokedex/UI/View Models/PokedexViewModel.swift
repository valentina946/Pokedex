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
    
    var offset = 0
    var limit : Int = 20
    
    init() {
        Task {
            await self.getAllPokemon()
        }
    }
    
    @Published public var pokemonNamesState = PokedexStatus()
    
    func getAllPokemon() async {

        Task {
            await MainActor.run {
                withAnimation {
                    self.pokemonNamesState.toLoading()
                }
            }
        }
        
        await getAllLocalPokemonsUseCase.execute(offset: offset, limit: limit)
            .map { $0.map { PPokemonDetails(pokemon: $0) } }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        Task {
                            await MainActor.run {
                                withAnimation(.default.speed(2)) {
                                    self.pokemonNamesState.updateState(error: error)
                                }
                            }
                        }
                    } else if self.pokemonNamesState.status == .loading || self.pokemonNamesState.status == .initial {
                        Task {
                            await MainActor.run {
                                withAnimation(.default.speed(2)) {
                                    self.pokemonNamesState.updateState(error: .localDataNotFound)
                                }
                            }
                        }
                    }
                },
                receiveValue: { values in
                    Task {
                        await MainActor.run {
                            withAnimation {
                                self.pokemonNamesState.updateState(pokedex: values)
                                self.offset = self.offset + 10
                            }
                        }
                    }
            })
            .store(in: &cancellable)
    }
    
}
