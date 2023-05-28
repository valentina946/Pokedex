//
//  APIPokedex.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 21/5/23.
//

import Foundation
import RealmSwift

struct APIPokedex: Codable {
    let count: Int
     let next: String?
     let previous: String?
    let results: [APIPokemon]
    
    func toDomain() -> Pokedex {
        return Pokedex(count: self.count, namesPokemon: results.map { $0.toDomain() } )
    }
   
}
