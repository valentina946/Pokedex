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
    private(set) var status: BaseViewModelStatus
    private(set) var pokedex: [PPokemonDetails]?
    private(set) var error: DomainError?
    
    // MARK: - Initialization

    init() { self.status = .initial }

    // MARK: - Public Methods

    mutating func toLoading() {
        self.status = .loading
        self.pokedex = nil
        self.error = nil
    }
    
    mutating func updateState(pokedex: [PPokemonDetails]?) {
        if pokedex == nil {
            self.status = .noContentError
            self.pokedex = nil
        } else {
            self.status = .success
            self.pokedex = pokedex
        }
        self.error = nil
    }

    mutating func updateState(error: DomainError) {
        switch status {
        case .initial:
            switch error {
            case .noConnectionToServer, .localDataNotUpdated:
                status = .noContentError
            case .localDataNotFound:
                status = .initial
            case .unknown:
                status = .unknownError
            }
        case .loading:
            switch error {
            case .noConnectionToServer, .localDataNotUpdated:
                status = .noContentError
            case .localDataNotFound:
                status = .loading
            case .unknown:
                status = .unknownError
            }
        case .success:
            switch error {
            case .noConnectionToServer, .localDataNotUpdated, .unknown:
                status = .outdatedContentError
            case .localDataNotFound:
                status = .noContentError
            }
        case .noContentError:
            switch error {
            case .noConnectionToServer, .localDataNotUpdated:
                status = .outdatedContentError
            case .localDataNotFound:
                status = .noContentError
            case .unknown:
                status = .unknownError
            }
        case .outdatedContentError:
            switch error {
            case .noConnectionToServer, .localDataNotUpdated:
                status = .outdatedContentError
            case .localDataNotFound:
                status = .noContentError
            case .unknown:
                status = .unknownError
            }
        case .unknownError:
            switch error {
            case .noConnectionToServer, .localDataNotFound, .localDataNotUpdated:
                status = .noContentError
            case .unknown:
                status = .unknownError
            }
        }
        self.error = error
        if self.status != .outdatedContentError {
            self.pokedex = nil
        }
    }
}

public enum PokedexScreenStatus {
    case INITIAL
    case SUCCESS
    case ERROR
    case LOADING
}
