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
    
}
