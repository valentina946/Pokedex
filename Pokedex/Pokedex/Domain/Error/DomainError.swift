//
//  DomainError.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation

public enum DomainError: Error, Equatable {
    case noConnectionToServer
    case localDataNotFound
    case localDataNotUpdated
    case unknown(description: String?)
}
