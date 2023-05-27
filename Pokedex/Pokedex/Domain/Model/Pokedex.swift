//
//  Pokedex.swift
//  Pokedex
//
//  Created by Valentina Olariaga on 22/5/23.
//

import Foundation

public struct Pokedex {
    let count: Int
    let namesPokemon: [Pokemon]
    
    init(count: Int, namesPokemon: [Pokemon]) {
        self.count = count
        self.namesPokemon = namesPokemon
    }
    
}

