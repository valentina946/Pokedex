//
//  FavouritePokemonsViewModelTest.swift
//  PokedexTests
//
//  Created by Valentina Olariaga on 29/5/23.
//

import XCTest
import Factory

@testable import Pokedex

final class FavouritePokemonsViewModelTest: XCTestCase {
    override func setUp() {
        super.setUp()
        Container.shared = Container()
    }
    
    override func tearDown() {
        super.tearDown()
    }
 
    func getFavouritePokemonsSuccess() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .success) }
        let favouritePokemonsViewModel = Container.shared.FavouritePokemonViewModel.callAsFunction()
        await favouritePokemonsViewModel.getAllFavouritePokemons()
        XCTAssert(favouritePokemonsViewModel.getFavouritesPokemonStatus.status == .success)
    }

    func getFavouritePokemonsFailureNoConnection() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .noConnectionToServer) }
        let favouritePokemonsViewModel = Container.shared.FavouritePokemonViewModel.callAsFunction()
        await favouritePokemonsViewModel.getAllFavouritePokemons()
        XCTAssert(favouritePokemonsViewModel.getFavouritesPokemonStatus.status == .noContentError && favouritePokemonsViewModel.getFavouritesPokemonStatus.error == .noConnectionToServer)
    }
    
    func getFavouritePokemonsFailureNoLocalData() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .localDataNotFound) }
        let favouritePokemonsViewModel = Container.shared.FavouritePokemonViewModel.callAsFunction()
        await favouritePokemonsViewModel.getAllFavouritePokemons()
        XCTAssert(favouritePokemonsViewModel.getFavouritesPokemonStatus.status == .loading && favouritePokemonsViewModel.getFavouritesPokemonStatus.error == .localDataNotFound)
    }
    
    func getFavouritePokemonsFailureDataNotUpdated() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .localDataNotUpdated) }
        let favouritePokemonsViewModel = Container.shared.FavouritePokemonViewModel.callAsFunction()
        await favouritePokemonsViewModel.getAllFavouritePokemons()
        XCTAssert(favouritePokemonsViewModel.getFavouritesPokemonStatus.status == .noContentError && favouritePokemonsViewModel.getFavouritesPokemonStatus.error == .localDataNotUpdated)
    }
    
    func saveFavouritePokemonSuccess() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .success) }
        let favouritePokemonsViewModel = Container.shared.FavouritePokemonViewModel.callAsFunction()
        let newPokemon =  FavouritePokemon(id: 3, name: "Snorlax", image: "image.jpg")
        let favouritePokemonsCount = MockDataTest.mockPokemonsFavourite.count
        await favouritePokemonsViewModel.saveFavouritePokemon(pokemon: newPokemon)
        XCTAssert(favouritePokemonsViewModel.getFavouritesPokemonStatus.status == .success && favouritePokemonsViewModel.getFavouritesPokemonStatus.pokedex?.count ==  favouritePokemonsCount + 1)
    }
    
    func saveFavouritePokemonFailureNoConnection() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .noConnectionToServer) }
        let favouritePokemonsViewModel = Container.shared.FavouritePokemonViewModel.callAsFunction()
        let newPokemon =  FavouritePokemon(id: 3, name: "Snorlax", image: "image.jpg")
        await favouritePokemonsViewModel.saveFavouritePokemon(pokemon: newPokemon)
        XCTAssert(favouritePokemonsViewModel.getFavouritesPokemonStatus.status == .noContentError && favouritePokemonsViewModel.getFavouritesPokemonStatus.error == .noConnectionToServer)
    }
    
    func saveFavouritePokemonFailureNoLocalData() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .localDataNotFound) }
        let favouritePokemonsViewModel = Container.shared.FavouritePokemonViewModel.callAsFunction()
        let newPokemon =  FavouritePokemon(id: 3, name: "Snorlax", image: "image.jpg")
        await favouritePokemonsViewModel.saveFavouritePokemon(pokemon: newPokemon)
        XCTAssert(favouritePokemonsViewModel.getFavouritesPokemonStatus.status == .loading && favouritePokemonsViewModel.getFavouritesPokemonStatus.error == .localDataNotFound)
    }
    
    func saveFavouritePokemonFailureDataNotUpdated() async throws {
        Container.shared.pokedexRepository.register { PokedexRepositoryMockData(testCase: .localDataNotUpdated) }
        let favouritePokemonsViewModel = Container.shared.FavouritePokemonViewModel.callAsFunction()
        let newPokemon =  FavouritePokemon(id: 3, name: "Snorlax", image: "image.jpg")
        await favouritePokemonsViewModel.saveFavouritePokemon(pokemon: newPokemon)
        XCTAssert(favouritePokemonsViewModel.getFavouritesPokemonStatus.status == .noContentError && favouritePokemonsViewModel.getFavouritesPokemonStatus.error == .localDataNotUpdated)
    }

}
