//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Valentina Olariaga on 19/5/23.
//

import XCTest
import Factory

@testable import Pokedex

final class PokedexTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Container.shared = Container()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func getAllPokemonSuccess() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .success) }
        let pokedexViewModel = Container.shared.pokedexViewModel.callAsFunction()
        await pokedexViewModel.getAllPokemon(isNextPress: true)
        XCTAssert(pokedexViewModel.pokemonNamesState.status == .success)
    }
    
    func getAllPokemonFailureNoConnection() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .noConnectionToServer) }
        let pokedexViewModel = Container.shared.pokedexViewModel.callAsFunction()
        await pokedexViewModel.getAllPokemon(isNextPress: true)
        XCTAssert(pokedexViewModel.pokemonNamesState.status == .noContentError && pokedexViewModel.pokemonNamesState.error == .noConnectionToServer)
    }
    
    func getAllPokemonFailureNoLocalData() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .localDataNotFound) }
        let pokedexViewModel = Container.shared.pokedexViewModel.callAsFunction()
        await pokedexViewModel.getAllPokemon(isNextPress: true)
        XCTAssert(pokedexViewModel.pokemonNamesState.status == .loading && pokedexViewModel.pokemonNamesState.error == .localDataNotFound)
    }
    
    func getAllPokemonFailureDataNotUpdated() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .localDataNotUpdated) }
        let pokedexViewModel = Container.shared.pokedexViewModel.callAsFunction()
        await pokedexViewModel.getAllPokemon(isNextPress: true)
        XCTAssert(pokedexViewModel.pokemonNamesState.status == .noContentError && pokedexViewModel.pokemonNamesState.error == .localDataNotUpdated)
    }

}
