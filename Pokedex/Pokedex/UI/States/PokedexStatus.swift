//
//  PokedexStatus.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 22/5/23.
//

import Foundation

enum BaseViewModelStatus: Equatable {
    case initial
    case loading
    case success
    case noContentError
    case outdatedContentError
    case unknownError
}

public struct PokedexStatus {
     var status: BaseViewModelStatus
     var pokedex: [PPokemonDetails]?
     var error: DomainError?
    
    init(status: BaseViewModelStatus, pokedex: [PPokemonDetails]? = nil ,error: DomainError? = nil) {
        self.status = status
        self.pokedex = pokedex
        self.error = error
    }

}

public enum PokedexScreenStatus {
    case INITIAL
    case SUCCESS
    case ERROR
    case LOADING
}
