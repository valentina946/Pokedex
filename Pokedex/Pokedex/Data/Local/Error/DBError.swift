//
//  DBError.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation

public enum DBError: Error {
    case queryError
    case mappingError
    case unknown(description: String)
    
    init(error: Error) {
        if let dbError = error as? DBError {
            self = dbError
        } else {
            self = .unknown(description: error.localizedDescription)
        }
    }
    
    func toDomain() -> DomainError {
        switch self {
        case .mappingError:
            return DomainError.unknown(description: "Model database error")
        case .queryError:
            return DomainError.localDataNotFound
        case .unknown(let description):
            return DomainError.unknown(description: description)
        }
    }
}
