//
//  APIError.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 22/5/23.
//

import Foundation

protocol DomainRepresentable {
    
    associatedtype DataType
    
    func toDomain() -> DataType
    
}

enum APIError: Error {
    
    case unknown(description: String?)
    
}

extension APIError: DomainRepresentable {
    
    func toDomain() -> DomainError {
        switch self {
        case .unknown(let description):
            return DomainError.unknown(description: "API: \(description ?? "unknown")")
        }
    }
    
}
