//
//  Pokemon.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 20/5/23.
//

import Foundation

struct Pokemon: Hashable {
    
    public static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
}
