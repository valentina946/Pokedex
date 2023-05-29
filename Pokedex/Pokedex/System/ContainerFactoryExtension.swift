//
//  ContainerFactoryExtension.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation
import Factory

extension Container {
    
    var pokedexViewModel: Factory<PokedexViewModel> { self { PokedexViewModel() } }
    var pokemonFavouriteViewModel: Factory<FavouritePokemonsViewModel> { self { FavouritePokemonsViewModel() } }
    
}

extension Container {
    
    var pokedexRemoteDataSource: Factory<PokedexRemoteDataSource> { self { PokedexRemoteDataSourceImpl() } }
    var pokedexLocalDataSource: Factory<PokedexLocalDataSource> { self { PokedexLocalDataSourceImpl() } }
    
}

extension Container {
    
    var pokedexRepository: Factory<PokedexRepository> { self { PokedexRepositoryImpl() } }
}

extension Container {
    
    var dataManager: Factory<DataManager> { self { DataManagerImpl() }.singleton }
    
}

extension Container {
    
    var getAllLocalPokemonsUseCase: Factory<GetAllLocalPokemonsUseCase> { self {GetAllLocalPokemonsUseCase(pokedexRepository: self.pokedexRepository.callAsFunction()) } }
    var getAllRemotePokemonsUseCase: Factory<GetAllRemotePokemonsUseCase> { self {GetAllRemotePokemonsUseCase(pokedexRepository: self.pokedexRepository.callAsFunction()) } }
    var getAllLocalFavouritePokemonsUseCase: Factory<GetAllLocalFavouritePokemonsUseCase> { self {GetAllLocalFavouritePokemonsUseCase(pokedexRepository: self.pokedexRepository.callAsFunction()) } }
    var saveFavouritePokemonUseCase: Factory<SaveFavouritePokemonUseCase> { self {SaveFavouritePokemonUseCase(pokedexRepository: self.pokedexRepository.callAsFunction()) } }
}
